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
end


Rake Tasks
------------------
If you want to add the rake tasks for uploader to your project you will need to add the following to your applications's Rakefile

  require 'uploader'
  require 'uploader/tasks'
  

The Basics
=================

You can modify the controller behavior by inheriting from the uploader controller.  For example,
to require the user be logged in to upload simply do this:

  class UploadsController < Uploader::UploadsController
    before_filter :login_required
  end




Copyright (c) 2009 Justin Ball, released under the MIT license
