require 'rake'
require 'rake/tasklib'
require 'fileutils'

module Uploader
  class Tasks < ::Rake::TaskLib
    def initialize
      define
    end
  
    private
    def define
      namespace :uploader do
        
        task :app_env do
          Rake::Task[:environment].invoke if defined?(RAILS_ROOT)
        end
        
        desc 'Send all uploads to S3.  (Will only send uploads from a model named Upload)'
        task :upload_to_s3 do
          uploads = Upload.pending_s3_migration
          uploads.each do |upload|
            upload.remote = upload.local
            upload.save!
          end
        end

        desc "Sync required files from uploader."
        task :sync do
          path = File.join(File.dirname(__FILE__), *%w[.. ..])
          daemons_path = "#{RAILS_ROOT}/lib/daemons"
          system "rsync -ruv #{path}/public ."
          system "rsync -ruv #{path}/db ."
          FileUtils.mkdir_p(daemons_path) unless File.directory?(daemons_path)          
          FileUtils.cp_r("#{path}/lib/daemons/amazonaws.rb", "#{RAILS_ROOT}/lib/daemons/amazonaws.rb")
        end
        
      end
    end
  end
end
Uploader::Tasks.new