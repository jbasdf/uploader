# == Schema Information
#
# Table name: uploads
#
#  id                  :integer         not null, primary key
#  creator_id          :integer
#  name                :string(255)
#  caption             :string(1000)
#  description         :text
#  is_public           :boolean         default(TRUE)
#  uploadable_id       :integer
#  uploadable_type     :string(255)
#  width               :string(255)
#  height              :string(255)
#  local_file_name     :string(255)
#  local_content_type  :string(255)
#  local_file_size     :integer
#  local_updated_at    :datetime
#  remote_file_name    :string(255)
#  remote_content_type :string(255)
#  remote_file_size    :integer
#  remote_updated_at   :datetime
#  created_at          :datetime
#  updated_at          :datetime
#

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
