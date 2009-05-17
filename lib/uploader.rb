require 'uploader/exceptions'
require 'uploader/mime_type_groups'
require 'uploader/middleware/flash_session_cookie_middleware'

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
  require 'mime-types'
rescue LoadError
  begin
    gem 'mime-types'
  rescue Gem::LoadError
    puts "Please install the mime-types gem"
  end
end
