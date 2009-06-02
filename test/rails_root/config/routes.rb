ActionController::Routing::Routes.draw do |map|

  map.resources :uploads, :collection => { :swfupload => :post }
  map.resources :users
  
end
