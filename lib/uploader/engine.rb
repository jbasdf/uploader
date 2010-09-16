require 'uploader'
require 'rails'

module Uploader
  class Engine < ::Rails::Engine

    def muck_name
      'uploader'
    end
    
    initializer "uploader.add_middleware" do |app|
      app.middleware.insert_before(ActionDispatch::Session::CookieStore, 
                                   Uploader::FlashSessionCookieMiddleware, 
                                   Rails.application.config.session_options[:key])
    end
    
    initializer 'uploader.uploader_helper' do |app|
      ActiveSupport.on_load(:action_view) do
        include UploaderHelper
      end
    end
  end
end