$:.reject! { |e| e.include? 'TextMate' }
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

require 'test_help'
gem 'thoughtbot-factory_girl' # from github
require 'factory_girl'
require 'ruby-debug'
require 'mocha'
require 'redgreen' rescue LoadError
require File.expand_path(File.dirname(__FILE__) + '/factories')
require File.join(File.dirname(__FILE__), 'shoulda_macros', 'paperclip')
class ActiveSupport::TestCase
  
  VALID_FILE = ActionController::TestUploadedFile.new(File.join(RAILS_ROOT, 'public/images/rails.png'), 'image/png')
  
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  
  def ensure_flash(val)
    assert_contains flash.values, val, ", Flash: #{flash.inspect}"
  end
end