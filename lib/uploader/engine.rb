require 'uploader'
require 'rails'

module Uploader
  class Engine < ::Rails::Engine

    initializer "uploader.add_middleware" do |app|
      app.middleware.use Uploader::FlashSessionCookieMiddleware
    end
    
    initializer 'uploader.uploader_helper' do |app|
      ActiveSupport.on_load(:action_view) do
        include UploaderHelper
      end
    end
      
  end
end