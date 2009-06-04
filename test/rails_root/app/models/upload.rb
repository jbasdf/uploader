class Upload < ActiveRecord::Base
  
  acts_as_uploader  :enable_s3 => true,
                    :has_attached_file => {
                      :url     => "/system/:attachment/:id_partition/:style/:basename.:extension",
                      :path    => ":rails_root/public/system/:attachment/:id_partition/:style/:basename.:extension",
                      :styles  => { :icon => "30x30!", 
                                    :thumb => "100>", 
                                    :small => "150>", 
                                    :medium => "300>", 
                                    :large => "660>" },
                      :default_url => "/images/profile_default.jpg",
                      :storage => :s3,
                      :s3_credentials => AMAZON_S3_CREDENTIALS,
                      :bucket => "assets.#{GlobalConfig.application_url}",
                      :s3_host_alias => "assets.#{GlobalConfig.application_url}",
                      :convert_options => {
                         :all => '-quality 80'
                       }
                    }

  validates_attachment_presence :local
  validates_attachment_size :local, :less_than => 10.megabytes

  def can_edit?(user)
    return true
  end

end
