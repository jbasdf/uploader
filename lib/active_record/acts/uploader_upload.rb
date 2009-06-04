module ActiveRecord
  module Acts #:nodoc:

    module UploaderUpload #:nodoc:
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        # acts_as_uploader requires an option for :has_attached_file.  These values will be passed to paperclip.
        # i.e.
        # acts_as_uploader :has_attached_file => {
        # :url     => "/uploads/:class/:id/:style_:basename.:extension",
        # :path    => ":rails_root/public/uploads/:class/:id/:style_:basename.:extension",
        # :styles  => { :icon => "30x30!", :thumb => "100>", :small => "150>", :medium => "300>", :large => "660>"},
        # :default_url => "/images/profile_default.jpg" }
        def acts_as_uploader(options)

          #Named scopes
          named_scope :newest_first, :order => "created_at DESC"
          named_scope :alphabetic, :order => "filename DESC"
          named_scope :recent, :order => "created_at DESC"
          named_scope :public, :conditions => 'is_public = true'
          named_scope :images, :conditions => "local_content_type IN (#{Uploader::MimeTypeGroups::IMAGE_TYPES.collect{|type| "'#{type}'"}.join(',')})"
          named_scope :documents, :conditions => "local_content_type IN (#{(Uploader::MimeTypeGroups::WORD_TYPES + Uploader::MimeTypeGroups::EXCEL_TYPES + Uploader::MimeTypeGroups::PDF_TYPES).collect{|type| "'#{type}'"}.join(',')})" 
          named_scope :files, :conditions => "local_content_type NOT IN (#{Uploader::MimeTypeGroups::IMAGE_TYPES.collect{|type| "'#{type}'"}.join(',')})"
          named_scope :since, lambda { |*args| { :conditions => ["created_at > ?", (args.first || 7.days.ago.to_s(:db)) ]} }
          named_scope :pending_s3_migration, lambda { { :conditions =>  ["remote_file_name IS NULL AND created_at <= ?", 20.minutes.ago.to_s(:db)], :order => 'created_at DESC' } }

          # Paperclip
          has_attached_file :local, options[:has_attached_file].merge(:storage => :filesystem) # Override any storage settings.  This one has to be local.
          has_attached_file :remote, options[:has_attached_file].merge(:url => ':s3_alias_url',
                                                                       :path => options[:s3_path],
                                                                       :storage => :s3)

          belongs_to :uploadable, :polymorphic => true
          belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
                                        
          class_eval <<-EOV
            
            before_post_process :transliterate_file_name
            before_create :add_width_and_height
            
            # prevents a user from submitting a crafted form that bypasses activation
            attr_protected :creator_id, :uploadable_id, :uploadable_type
          EOV

          include ActiveRecord::Acts::UploaderUpload::InstanceMethods
          extend ActiveRecord::Acts::UploaderUpload::SingletonMethods
        end
      end

      # class methods
      module SingletonMethods

      end
      
      # All the methods available to a record that has had <tt>acts_as_uploader</tt> specified.
      module InstanceMethods
        
        def file
          local_file_name ? local : remote
        end

        def file_name
          remote_file_name || local_file_name
        end
        
        def send_to_remote
          if local_file_name
            self.remote = local.to_file
            if self.save and remote.original_filename and remote.exists?
              self.local = nil
              self.save
            else
              false
            end
          end
        end
        
        def swfupload_local=(filedata)
          filedata.content_type = MIME::Types.type_for(filedata.original_filename)[0].to_s
          self.local = filedata
        end
        
        def is_image?
          Uploader::MimeTypeGroups::IMAGE_TYPES.include?(self.local_content_type)
        end

        def is_mp3?
          Uploader::MimeTypeGroups::MP3_TYPES.include?(self.local_content_type)
        end

        def is_excel?
          Uploader::MimeTypeGroups::EXCEL_TYPES.include?(self.local_content_type)
        end

        def is_pdf?
          Uploader::MimeTypeGroups::PDF_TYPES.include?(self.local_content_type)
        end

        def is_word?
          Uploader::MimeTypeGroups::WORD_TYPES.include?(self.local_content_type)
        end

        def is_text?
          Uploader::MimeTypeGroups::TEXT_TYPES.include?(self.local_content_type)
        end
        
        def upload_type
          if self.is_pdf?
            'Adobe pdf file'
          elsif self.is_word?
            'Word document'
          elsif self.is_image?
            'photo'
          elsif self.is_mp3?
            'mp3'
          elsif self.is_excel?
            'Excel document'
          elsif self.is_text?
            'text file'
          else
            'file'
          end
        end

        def icon
          if self.is_pdf?
            '/images/file_icons/file_pdf.gif'
          elsif self.is_word?
            '/images/file_icons/file_doc.gif'
          elsif self.is_image?
            self.file.url(:icon)
          elsif self.is_mp3?
            '/images/file_icons/file_mp3.gif'
          elsif self.is_excel?
            '/images/file_icons/file_xls.gif'
          elsif self.is_text?
            '/images/file_icons/file_txt.gif'
          else
            '/images/file_icons/file_raw.gif'
          end
        end
        
        def display_name
          CGI::escapeHTML(self.local_file_name)
        end
        
        def can_edit?(check_user)
          return false if check_user.blank?
          check_user == self.creator
        end
        
        # Image dimension calculations

        def width(style = :default)
          return nil unless self[:width]
          return self[:width] if style == :default
          calculate_sizes(style.to_sym)
          return @image_width.to_i
        end

        def height(style = :default)
          return nil unless self[:height]
          return self[:height] if style == :default
          calculate_sizes(style.to_sym)
          return @image_height.to_i
        end

        def size(style = :default)
          return nil unless width || height
          return "#{width}x#{height}" if style == :default
          calculate_sizes(style.to_sym)
          return @image_size
        end

        def max_dimension(style)
          @max_dimension ||= Paperclip::Geometry.parse(self.local.styles[style][:geometry]).width.to_f
        end

        def image_ratio
          @image_ratio ||= width.to_f / height.to_f
        end

        def calculate_sizes(style)
          if image_ratio > 1
            @image_width ||= width > max_dimension(style) ? max_dimension(style) : width
            @image_height ||= (@image_width / image_ratio).round
          else
            @image_height ||= height > max_dimension(style) ? max_dimension(style) : height
            @image_width ||= (@image_height * image_ratio).round
          end
          @image_size ||= "#{@image_width.to_i}x#{@image_height.to_i}"
        end
        
        protected
          def transliterate_file_name
            extension = File.extname(local_file_name).gsub(/^\.+/, '')
            filename = local_file_name.gsub(/\.#{extension}$/, '')
            self.local.instance_write(:file_name, "#{transliterate(filename)}.#{transliterate(extension)}")
          end
          
          def transliterate(str)
            # Lifted from permalink_fu by Rick Olsen
            # Escape str by transliterating to UTF-8 with Iconv,
            # downcasing, then removing illegal characters and replacing them with ’-’
            s = Iconv.iconv('ascii//ignore//translit', 'utf-8', str).to_s
            s.downcase!
            s.gsub!(/\'/, '')
            s.gsub!(/[^A-Za-z0-9]+/, ' ')
            s.strip!
            s.gsub!(/\ +/, '-') # set single or multiple spaces to a single dash
            return s
          end
          
          def add_width_and_height
            return unless self.is_image?
            if self.local.to_file
              geometry = Paperclip::Geometry.from_file self.local.to_file
              self[:width] = geometry.width.to_i
              self[:height] = geometry.height.to_i
            end
          end
          
      end 
    end
  end
end
