require 'mime/types'

module Uploader
  module Models
    module Upload
      extend ActiveSupport::Concern
    
      included do
        
        scope :newest, order("created_at DESC")
        scope :by_filename, order("local_file_name DESC")
        scope :newest, order("created_at DESC")
        scope :is_public, where('is_public = true')
        scope :images, where("local_content_type IN (#{Uploader::MimeTypeGroups::IMAGE_TYPES.collect{|type| "'#{type}'"}.join(',')})")
        scope :documents, where("local_content_type IN (#{(Uploader::MimeTypeGroups::WORD_TYPES + Uploader::MimeTypeGroups::EXCEL_TYPES + Uploader::MimeTypeGroups::PDF_TYPES).collect{|type| "'#{type}'"}.join(',')})")
        scope :files, where("local_content_type NOT IN (#{Uploader::MimeTypeGroups::IMAGE_TYPES.collect{|type| "'#{type}'"}.join(',')})")
        scope :recent, lambda { |*args| where("created_at > ?", args.first || 7.days.ago.to_s(:db)) }
        scope :created_by, lambda { |creator_id| where("creator_id = ?", creator_id) }
        scope :pending_s3_migrations, where("remote_file_name IS NULL").order('created_at DESC')
      
        # Paperclip
        has_attached_file :local, Uploader.configuration.has_attached_file_options.merge(:storage => :filesystem) # Override any storage settings.  This one has to be local.
        has_attached_file :remote, Uploader.configuration.has_attached_file_options

        belongs_to :uploadable, :polymorphic => true
        belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
      
        before_save :determine_immediate_send_to_remote
        
        before_post_process :transliterate_file_name
        before_post_process :halt_nonimage_processing unless Uploader.configuration.disable_halt_nonimage_processing
        before_create :add_width_and_height
      
        # Protect data in the model
        attr_protected :creator_id, :uploadable_id, :uploadable_type
      end

      module ClassMethods
      
      end
        
      def file
        local_file_name ? local : remote
      end

      def file_name
        remote_file_name || local_file_name
      end
    
      def determine_immediate_send_to_remote
        if Uploader.configuration.s3_no_wait
          self.remote = local.to_file # This will result in the file being sent to S3
        end
      end
    
      def send_to_remote
        if local_file_name
          self.remote = local.to_file
          if self.save and remote.original_filename and remote.exists?
            self.local = nil unless Uploader.configuration.keep_local_file
            self.save
          else
            false
          end
        end
      end
    
      def multiupload_local=(filedata)
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
    
      # Only works for images
      def thumb
        if self.is_image?
          self.file.url(:thumb)
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
      
        def halt_nonimage_processing
          if !self.is_image? && self.local.options[:styles]
            return false
          end
        end
      
    end
  end
end