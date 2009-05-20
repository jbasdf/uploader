ActionController::Routing::Routes.draw do |map|
  map.resources :uploads, :controller => 'uploader/uploads', :collection => { :swfupload => :post }
end
