require 'rake'
require 'rake/testtask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the uploader gem.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test/rails_test/test'
  t.pattern = 'test/rails_test/test/**/*_test.rb'
  t.verbose = true
end

require 'rake/rdoctask'
desc 'Generate documentation for the uploader plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Uploader'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Translate this gem'
task :translate do
  file = File.join(File.dirname(__FILE__), 'config', 'locales', 'en.yml')
  system("babelphish -o -y #{file}")
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "uploader"
    gem.summary = "Uploadify, SWFUpload + Paperclip wrapped in an engine with love."
    gem.email = "justinball@gmail.com"
    gem.homepage = "http://github.com/jbasdf/uploader"
    gem.description = "Uploader gem that makes it simple add multiple file uploads to your Rails project using SWFUpload, Uploadify and Paperclip"
    gem.authors = ["Justin Ball", "Joel Duffin", "David South"]
    gem.add_dependency "mime-types"
    gem.add_dependency "rack"
    gem.add_dependency "paperclip"
    gem.add_dependency "aws-s3"
    gem.files.exclude 'test/**'
  end
  Jeweler::RubygemsDotOrgTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
