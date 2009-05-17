require 'uploader'
require 'uploader/initialize_routes'

ActionController::Dispatcher.middleware.use FlashSessionCookieMiddleware, ActionController::Base.session_options[:key]

config.to_prepare do
  ApplicationController.helper(UploaderHelper)
end

I18n.load_path += Dir[ File.join('..', 'locales', '*.{rb,yml}') ]
