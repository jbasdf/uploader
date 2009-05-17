require 'uploader/exceptions'
require 'uploader/languages'
require 'fileutils'

if config.respond_to?(:gems)
  config.gem 'mime-types'
else
  begin
    require 'mime-types'
  rescue LoadError
    begin
      gem 'mime-types'
    rescue Gem::LoadError
      puts "Please install the mime-types gem"
    end
  end
end

require 'uploader/mime_type_groups'

