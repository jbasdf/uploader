Rails.application.routes.draw do
  resources :uploads, 
    :controller => 'uploader/uploads' do
    collection do
      post :multiupload
    end
  end
end
