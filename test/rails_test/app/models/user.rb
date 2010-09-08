# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  
  has_many :uploads, :as => :uploadable, :order => 'created_at desc', :dependent => :destroy
  
  def can_upload?(user)
    self.id == user.id
  end
  
end
