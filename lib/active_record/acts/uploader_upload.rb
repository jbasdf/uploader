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
          named_scope :images, :conditions => "data_content_type IN (#{Uploader::MimeTypeGroups::IMAGE_TYPES.collect{|type| "'#{type}'"}.join(',')})"
          named_scope :documents, :conditions => "data_content_type IN (#{(Uploader::MimeTypeGroups::WORD_TYPES + Uploader::MimeTypeGroups::EXCEL_TYPES + Uploader::MimeTypeGroups::PDF_TYPES).collect{|type| "'#{type}'"}.join(',')})" 
          named_scope :files, :conditions => "data_content_type NOT IN (#{Uploader::MimeTypeGroups::IMAGE_TYPES.collect{|type| "'#{type}'"}.join(',')})"
          named_scope :since, lambda { |*args| { :conditions => ["created_at > ?", (args.first || 7.days.ago.to_s(:db)) ]} }

          has_attached_file :data, options[:has_attached_file]
          
          belongs_to :uploadable, :polymorphic => true
                                        
          class_eval <<-EOV
            validates_attachment_presence :data
          
            # prevents a user from submitting a crafted form that bypasses activation
            attr_protected :user_id, :uploadable_id, :uploadable_type
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
        
        def max_upload_size
          # TODO this should be passed in via options
          raise 'not implemented'
        end
        
        def swfupload_file=(filedata)
          filedata.content_type = MIME::Types.type_for(filedata.original_filename).to_s
          self.data = filedata
        end
        
        def creator
          self.user
        end
        
        def is_image?
          Uploader::MimeTypeGroups::IMAGE_TYPES.include?(self.data_content_type)
        end

        def is_mp3?
          Uploader::MimeTypeGroups::MP3_TYPES.include?(self.data_content_type)
        end

        def is_excel?
          Uploader::MimeTypeGroups::EXCEL_TYPES.include?(self.data_content_type)
        end

        def is_pdf?
          Uploader::MimeTypeGroups::PDF_TYPES.include?(self.data_content_type)
        end

        def is_word?
          Uploader::MimeTypeGroups::WORD_TYPES.include?(self.data_content_type)
        end

        def is_text?
          Uploader::MimeTypeGroups::TEXT_TYPES.include?(self.data_content_type)
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
            '/images/file_icons/pdf.gif'
          elsif self.is_word?
            '/images/file_icons/word.png'
          elsif self.is_image?
            self.data.url(:icon)
          elsif self.is_mp3?
            '/images/file_icons/mp3.png'
          elsif self.is_excel?
            '/images/file_icons/excel.png'
          elsif self.is_text?
            '/images/file_icons/text.png'
          else
            '/images/blurp_file.png'
          end
        end
        
        def display_name
          CGI::escapeHTML(self.login)
        end
        
        def can_edit?(check_user)
          return false if user.blank?
          check_user == self.user
        end
        
      end 
    end
  end
end
