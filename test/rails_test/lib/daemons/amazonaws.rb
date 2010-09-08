#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/environment"

$running = true
Signal.trap("TERM") do 
  $running = false
end

# Waiting is a timer variable to allow the daemon to restart
# within two seconds of the Signal rather than using a long
# sleep command and forcing the daemon to wait.
$waiting = 0

ActiveRecord::Base.logger.info "[AmazonS3] Migration daemon started at #{Time.now}.\n"

while($running) do

  if $waiting < 120
    $waiting += 2
    sleep 2
  else
    $waiting = 0
    upload = Upload.pending_s3_migrations.first

    if upload
      $waiting = 120 - 2
      ActiveRecord::Base.logger.info "[AmazonS3] Migrating upload ##{upload.id}\n"
      upload.remote = upload.local
      upload.save!
    end
  end
end