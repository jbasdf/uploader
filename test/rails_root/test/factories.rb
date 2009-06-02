Factory.sequence :name do |n|
  "a_name#{n}"
end

Factory.define :user do |f|
  f.name { Factory.next(:name) }
end

Factory.define :upload do |f|
  f.creator {|a| a.association(:user)}
  f.uploadable {|a| a.association(:user)}
  f.caption { Factory.next(:name) }
  f.local ActionController::TestUploadedFile.new(File.join(RAILS_ROOT, 'public/images/rails.png'), 'image/gif')
end