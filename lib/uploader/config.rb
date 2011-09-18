# Configures the uploader gem
#
# For example:
#   Uploader.configure do |config|
#     config.enable_s3 = true
#     config.s3_no_wait = true
#     config.keep_local_file = true
#     config.has_attached_file_options = {
#       :url               => "/system/:attachment/:id_partition/:style/:basename.:extension",
#       :path              => ":rails_root/public:url",
#       :styles  => { :icon => "30x30!", 
#                     :thumb => "100>", 
#                     :small => "150>", 
#                     :medium => "300>", 
#                     :large => "660>" },
#       :default_url => "/images/default.jpg",
#       :storage => :s3,
#       :s3_credentials => AMAZON_S3_CREDENTIALS,
#       :bucket => "assets.example.com",
#       :s3_host_alias => "assets.example.com",
#       :convert_options => {
#         :all => '-quality 80'
#       }
#    }            
#   end
module Uploader

  def self.configuration
    # In case the user doesn't setup a configure block we can always return default settings:
    @configuration ||= Configuration.new
  end
  
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :has_attached_file_options
    attr_accessor :enable_s3
    attr_accessor :s3_no_wait
    attr_accessor :keep_local_file
    attr_accessor :disable_halt_nonimage_processing
    attr_accessor :temp_dir
    attr_accessor :use_http_status_failures # This only applies to json requests

    def initialize
      @enable_s3 = false
      @s3_no_wait = false
      @keep_local_file = true
      @disable_halt_nonimage_processing = false
      @temp_dir = Dir::tmpdir
      @use_http_status_failures = false
      @has_attached_file_options = {
        :url               => "/system/:attachment/:id_partition/:style/:basename.:extension",
        :path              => ":rails_root/public:url", 
        :styles  => { :icon => "30x30!", 
                      :thumb => "100>", 
                      :small => "150>", 
                      :medium => "300>", 
                      :large => "660>" },
        :default_url => "/images/default.jpg",
        :convert_options => {
           :all => '-quality 80'
         }
      }
    end
  end
end
