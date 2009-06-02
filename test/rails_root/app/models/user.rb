class User < ActiveRecord::Base
  
  has_many :uploads, :as => :uploadable, :order => 'created_at desc', :dependent => :destroy
  
  def can_upload?(user)
    self.id == user.id
  end
  
end