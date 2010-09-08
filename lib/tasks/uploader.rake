namespace :uploader do
  
  desc 'Send all uploads to S3.  (Will only send uploads from a model named Upload)'
  task :upload_to_s3 => :environment do
    uploads = Upload.pending_s3_migrations
    uploads.each do |upload|
      upload.remote = upload.local
      upload.save!
    end
  end

  desc "Sync required files from uploader."
  task :sync => :environment do
    path = File.join(File.dirname(__FILE__), *%w[.. ..])
    daemons_path = "#{::Rails.root.to_s}/lib/daemons"
    system "rsync -ruv #{path}/public ."
    system "rsync -ruv #{path}/db ."
    FileUtils.mkdir_p(daemons_path) unless File.directory?(daemons_path)          
    FileUtils.cp_r("#{path}/lib/daemons/amazonaws.rb", "#{::Rails.root.to_s}/lib/daemons/amazonaws.rb")
  end
  
end
