begin
  require 'thoughtbot-paperclip'
rescue LoadError
  begin
    gem 'thoughtbot-paperclip'
  rescue Gem::LoadError
    puts "Please install the thoughtbot-paperclip gem"
  end
end

begin
  require 'mime/types'
rescue LoadError
  begin
    gem 'mime-types'
  rescue Gem::LoadError
    puts "Please install the mime-types gem"
  end
end

require 'uploader'
require 'uploader/initialize_routes'

ActiveRecord::Base.class_eval { include ActiveRecord::Acts::UploaderUpload }
ActionController::Base.send :helper, UploaderHelper
I18n.load_path += Dir[ File.join(File.dirname(__FILE__), '..', 'locales', '*.{rb,yml}') ]

config.after_initialize do
  ActionController::Dispatcher.middleware.use Uploader::FlashSessionCookieMiddleware, ActionController::Base.session_options[:key]
end
