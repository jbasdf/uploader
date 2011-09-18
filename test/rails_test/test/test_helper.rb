$:.reject! { |e| e.include? 'TextMate' }
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'
include ActionDispatch::TestProcess

require File.expand_path(File.dirname(__FILE__) + '/factories')
require File.join(File.dirname(__FILE__), 'shoulda_macros', 'paperclip')

class ActiveSupport::TestCase
  
  VALID_FILE = fixture_file_upload('rails.png', 'image/png')
  VALID_TEXT_FILE = fixture_file_upload('test.txt', 'text/plain')
  VALID_PDF_FILE = fixture_file_upload('test.pdf', 'application/pdf')
  VALID_WORD_FILE = fixture_file_upload('test.doc', 'application/word')
  VALID_EXCEL_FILE = fixture_file_upload('test.xls', 'application/excel')
  
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  
  def ensure_flash(val)
    assert_contains flash.values, val, ", Flash: #{flash.inspect}"
  end
end

class ActionController::TestRequest 
  def set_header(name, value)
    @env[name] = value
  end
end