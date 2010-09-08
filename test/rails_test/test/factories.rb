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
  f.local fixture_file_upload('rails.png', 'image/png')
end