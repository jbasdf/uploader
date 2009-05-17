Uploader
=================
Uploader makes it easy to integrate multiple file uploads into your application using SWFUpload

Installation
=================

Install Dependancies:
------------------
sudo gem install mime-types


Install the gem:
------------------
sudo gem install uploader


Add the gem to environment.rb
------------------
config.gem 'uploader'


Create a model for uploads.  We recommend upload.rb

  class Upload < ActiveRecord::Base
    acts_as_upload
    
    # only allow images:
    # validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg']
  end

Rake Tasks
------------------
Add the rake tasks for uploader to your project.  You will need to add the following to your applications's Rakefile

  require 'uploader'
  require 'uploader/tasks'

Then run:
  rake uploader:sync

That will copy all the required javascript and asset files into your project

The Basics
=================

You can modify the controller behavior by inheriting from the uploader controller.  For example,
to require the user be logged in to upload simply do this:

  class UploadsController < Uploader::UploadsController
    before_filter :login_required
  end

Be sure to modify your routes file as well:
  
  map.resources :uploads
  
Doing so will ensure that your application uses the new uploads controller instead of directly using the one inside the gem.



Copyright (c) 2009 Justin Ball, released under the MIT license
