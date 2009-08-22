RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

# Load a global constant so the initializers can use them
require 'ostruct'
require 'yaml'

::GlobalConfig = OpenStruct.new(YAML.load_file("#{RAILS_ROOT}/config/global_config.yml")[RAILS_ENV])

class << GlobalConfig
  def prepare_options_for_attachment_fu(options)
    attachment_fu_options = options.symbolize_keys.merge({:storage => options['storage'].to_sym, 
        :max_size => options['max_size'].to_i.megabytes})  
  end
end

class TestGemLocator < Rails::Plugin::Locator
  def plugins
    Rails::Plugin.new(File.join(File.dirname(__FILE__), *%w(.. .. ..)))
  end 
end

Rails::Initializer.run do |config|
  config.load_paths += Dir.glob(File.join(RAILS_ROOT, 'vendor', 'gems', '*', 'lib'))
  config.time_zone = 'UTC'
  config.gem 'thoughtbot-paperclip',  :version => '~> 2.2.2', :lib => 'paperclip', :source => 'http://gems.github.com'
  config.plugin_locators << TestGemLocator
end