require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the uploader gem.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test/rails_root/test'
  t.pattern = 'test/rails_root/test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the uploader plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Uploader'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Translate this gem'
task :translate do
  file = File.join(File.dirname(__FILE__), 'locales', 'en.yml')
  system("babelphish -o -y #{file}")
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "uploader"
    gemspec.summary = "SWFUpload + Paperclip wrapped in an engine with love."
    gemspec.email = "justinball@gmail.com"
    gemspec.homepage = "http://github.com/jbasdf/uploader"
    gemspec.description = "Uploader gem that makes it simple add multiple file uploads to your Rails project using SWFUpload and Paperclip"
    gemspec.authors = ["Justin Ball", "David South"]
    gemspec.files.include %w( test/rails_root/db/schema.rb )
    gemspec.rubyforge_project = 'uploader'
    gemspec.add_dependency "mime-types"
    gemspec.add_dependency "rack"
  end
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
