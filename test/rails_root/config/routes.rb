ActionController::Routing::Routes.draw do |map|

  map.resources :uploads, :collection => { :swfupload => :post }
  map.resources :users
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
