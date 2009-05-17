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
        
        desc 'Send all uploads to S3'
        task :upload_to_s3 do
          # TODO write rake task to upload to s3
        end

        desc "Sync required files from uploader."
        task :sync do
          system "rsync -ruv vendor/plugins/uploader/public ."
          system "rsync -ruv vendor/plugins/uploader/db ."
        end
        
      end
    end
  end
end
Uploader::Tasks.new