RailsTest::Application.routes.draw do
  
  root :to => "default#index"
  
  resources :uploads do
    collection do
      post :multiupload
    end
  end
  resources :users

  match ':controller(/:action(/:id(.:format)))'
end
