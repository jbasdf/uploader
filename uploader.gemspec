# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{uploader}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin Ball", "David South"]
  s.date = %q{2009-05-20}
  s.description = %q{Uploader gem that makes it simple add multiple file uploads to your Rails project using SWFUpload and Paperclip}
  s.email = %q{justinball@gmail.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "MIT-LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "app/controllers/uploader/uploads_controller.rb",
     "app/helpers/uploader_helper.rb",
     "app/views/uploads/_swf_upload.html.erb",
     "config/uploader_routes.rb",
     "db/migrate/20090517040220_create_uploads.rb",
     "db/migrate/20090517040220_create_uploads.rb",
     "lib/active_record/acts/uploader_upload.rb",
     "lib/uploader.rb",
     "lib/uploader/exceptions.rb",
     "lib/uploader/exceptions.rb",
     "lib/uploader/initialize_routes.rb",
     "lib/uploader/initialize_routes.rb",
     "lib/uploader/middleware/flash_session_cookie_middleware.rb",
     "lib/uploader/middleware/flash_session_cookie_middleware.rb",
     "lib/uploader/mime_type_groups.rb",
     "lib/uploader/mime_type_groups.rb",
     "lib/uploader/tasks.rb",
     "lib/uploader/tasks.rb",
     "locales/ar.yml",
     "locales/bg.yml",
     "locales/ca.yml",
     "locales/cs.yml",
     "locales/da.yml",
     "locales/de.yml",
     "locales/el.yml",
     "locales/en.yml",
     "locales/es.yml",
     "locales/fr.yml",
     "locales/it.yml",
     "locales/iw.yml",
     "locales/ja.yml",
     "locales/ko.yml",
     "locales/lt.yml",
     "locales/lv.yml",
     "locales/nl.yml",
     "locales/no.yml",
     "locales/pl.yml",
     "locales/pt.yml",
     "locales/ro.yml",
     "locales/ru.yml",
     "locales/sk.yml",
     "locales/sl.yml",
     "locales/sr.yml",
     "locales/sv.yml",
     "locales/tl.yml",
     "locales/uk.yml",
     "locales/vi.yml",
     "locales/zh-CN.yml",
     "locales/zh-TW.yml",
     "locales/zh.yml",
     "pkg/uploader-0.1.0.gem",
     "public/images/SWFUploadButton.png",
     "public/javascripts/swfupload/fileprogress.js",
     "public/javascripts/swfupload/handlers.js",
     "public/javascripts/swfupload/swfupload.cookies.js",
     "public/javascripts/swfupload/swfupload.js",
     "public/javascripts/swfupload/swfupload.queue.js",
     "public/javascripts/swfupload/swfupload.swfobject.js",
     "public/stylesheets/swfupload.css",
     "public/swf/swfupload.swf",
     "rails/init.rb",
     "tasks/rails.rake",
     "tasks/rails.rake",
     "test/test_helper.rb",
     "test/unit/upload_test.rb",
     "uninstall.rb",
     "uploader.gemspec"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/jbasdf/uploader}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{uploader}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{SWFUpload + Paperclip wrapped in an engine with love.}
  s.test_files = [
    "test/test_helper.rb",
     "test/unit/upload_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
