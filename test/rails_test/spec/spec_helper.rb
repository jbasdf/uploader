$:.reject! { |e| e.include? 'TextMate' }
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require 'rspec/core'
require 'rspec/mocks'
require 'rspec/expectations'
require 'rspec/rails'

require 'shoulda'
require 'factory_girl'
require "paperclip/matchers"
require 'authlogic/test_case'

include ActionDispatch::TestProcess

require File.expand_path(File.dirname(__FILE__) + '/factories')

RSpec.configure do |config|
  config.mock_with :rspec
  config.color_enabled = true
  config.include(RSpec::Mocks::Methods)
  config.include(Authlogic::TestCase)
  config.include(Paperclip::Shoulda::Matchers)
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false  
end

FIXTURES_PATH = "#{::Rails.root}/spec/fixtures/"
VALID_FILE = fixture_file_upload("#{FIXTURES_PATH}rails.png", "image/png")
VALID_TEXT_FILE = fixture_file_upload("#{FIXTURES_PATH}test.txt", "text/plain")
VALID_PDF_FILE = fixture_file_upload("#{FIXTURES_PATH}test.pdf", "application/pdf")
VALID_WORD_FILE = fixture_file_upload("#{FIXTURES_PATH}test.doc", "application/word")
VALID_EXCEL_FILE = fixture_file_upload("#{FIXTURES_PATH}test.xls", "application/excel")
  
class ActionController::TestRequest 
  def set_header(name, value)
    @env[name] = value
  end
end