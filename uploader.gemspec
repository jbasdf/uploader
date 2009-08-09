# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{uploader}
  s.version = "0.1.19"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin Ball", "David South"]
  s.date = %q{2009-08-08}
  s.description = %q{Uploader gem that makes it simple add multiple file uploads to your Rails project using SWFUpload and Paperclip}
  s.email = %q{justinball@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "TODO",
     "VERSION",
     "app/controllers/uploader/uploads_controller.rb",
     "app/helpers/uploader_helper.rb",
     "app/views/uploads/_swf_javascript.html.erb",
     "app/views/uploads/_swf_upload.html.erb",
     "config/uploader_routes.rb",
     "db/migrate/20090517040220_create_uploads.rb",
     "lib/active_record/acts/uploader_upload.rb",
     "lib/daemons/amazonaws.rb",
     "lib/uploader.rb",
     "lib/uploader/exceptions.rb",
     "lib/uploader/initialize_routes.rb",
     "lib/uploader/middleware/flash_session_cookie_middleware.rb",
     "lib/uploader/mime_type_groups.rb",
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
     "public/images/SWFUploadButton.png",
     "public/images/file_icons/excel.gif",
     "public/images/file_icons/file.gif",
     "public/images/file_icons/file.png",
     "public/images/file_icons/file_aac.gif",
     "public/images/file_icons/file_ai.gif",
     "public/images/file_icons/file_avi.gif",
     "public/images/file_icons/file_bin.gif",
     "public/images/file_icons/file_bmp.gif",
     "public/images/file_icons/file_cue.gif",
     "public/images/file_icons/file_divx.gif",
     "public/images/file_icons/file_doc.gif",
     "public/images/file_icons/file_eps.gif",
     "public/images/file_icons/file_flac.gif",
     "public/images/file_icons/file_flv.gif",
     "public/images/file_icons/file_gif.gif",
     "public/images/file_icons/file_html.gif",
     "public/images/file_icons/file_ical.gif",
     "public/images/file_icons/file_indd.gif",
     "public/images/file_icons/file_inx.gif",
     "public/images/file_icons/file_iso.gif",
     "public/images/file_icons/file_jpg.gif",
     "public/images/file_icons/file_mov.gif",
     "public/images/file_icons/file_mp3.gif",
     "public/images/file_icons/file_mpg.gif",
     "public/images/file_icons/file_pdf.gif",
     "public/images/file_icons/file_php.gif",
     "public/images/file_icons/file_png.gif",
     "public/images/file_icons/file_pps.gif",
     "public/images/file_icons/file_ppt.gif",
     "public/images/file_icons/file_psd.gif",
     "public/images/file_icons/file_qxd.gif",
     "public/images/file_icons/file_qxp.gif",
     "public/images/file_icons/file_raw.gif",
     "public/images/file_icons/file_rtf.gif",
     "public/images/file_icons/file_svg.gif",
     "public/images/file_icons/file_tif.gif",
     "public/images/file_icons/file_txt.gif",
     "public/images/file_icons/file_vcf.gif",
     "public/images/file_icons/file_wav.gif",
     "public/images/file_icons/file_wma.gif",
     "public/images/file_icons/file_xls.gif",
     "public/images/file_icons/file_xml.gif",
     "public/images/file_icons/mp3.gif",
     "public/images/file_icons/pdf.gif",
     "public/images/file_icons/pdf.png",
     "public/images/file_icons/text.gif",
     "public/images/file_icons/text.png",
     "public/images/file_icons/word.gif",
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
     "test/rails_root/.gitignore",
     "test/rails_root/.rake_tasks",
     "test/rails_root/Capfile",
     "test/rails_root/Rakefile",
     "test/rails_root/app/controllers/application_controller.rb",
     "test/rails_root/app/controllers/uploads_controller.rb",
     "test/rails_root/app/models/.keep",
     "test/rails_root/app/models/upload.rb",
     "test/rails_root/app/models/user.rb",
     "test/rails_root/app/views/layouts/application.html.erb",
     "test/rails_root/config/amazon_s3.yml",
     "test/rails_root/config/boot.rb",
     "test/rails_root/config/database.yml",
     "test/rails_root/config/environment.rb",
     "test/rails_root/config/environments/development.rb",
     "test/rails_root/config/environments/production.rb",
     "test/rails_root/config/environments/test.rb",
     "test/rails_root/config/global_config.yml",
     "test/rails_root/config/initializers/inflections.rb",
     "test/rails_root/config/initializers/mime_types.rb",
     "test/rails_root/config/initializers/requires.rb",
     "test/rails_root/config/initializers/s3_credentials.rb",
     "test/rails_root/config/initializers/session_store.rb",
     "test/rails_root/config/initializers/uploader.rb",
     "test/rails_root/config/routes.rb",
     "test/rails_root/db/.keep",
     "test/rails_root/db/development.sqlite3",
     "test/rails_root/db/migrate/20090517040220_create_uploads.rb",
     "test/rails_root/db/migrate/20090602041838_create_users.rb",
     "test/rails_root/db/schema.rb",
     "test/rails_root/db/test.sqlite3",
     "test/rails_root/features/step_definitions/webrat_steps.rb",
     "test/rails_root/features/support/env.rb",
     "test/rails_root/public/.htaccess",
     "test/rails_root/public/404.html",
     "test/rails_root/public/422.html",
     "test/rails_root/public/500.html",
     "test/rails_root/public/dispatch.rb",
     "test/rails_root/public/favicon.ico",
     "test/rails_root/public/images/rails.png",
     "test/rails_root/public/javascripts/application.js",
     "test/rails_root/public/javascripts/builder.js",
     "test/rails_root/public/javascripts/controls.js",
     "test/rails_root/public/javascripts/dragdrop.js",
     "test/rails_root/public/javascripts/effects.js",
     "test/rails_root/public/javascripts/prototype.js",
     "test/rails_root/public/javascripts/scriptaculous.js",
     "test/rails_root/public/javascripts/slider.js",
     "test/rails_root/public/javascripts/sound.js",
     "test/rails_root/public/robots.txt",
     "test/rails_root/public/stylesheets/.keep",
     "test/rails_root/script/about",
     "test/rails_root/script/breakpointer",
     "test/rails_root/script/console",
     "test/rails_root/script/create_project.rb",
     "test/rails_root/script/cucumber",
     "test/rails_root/script/dbconsole",
     "test/rails_root/script/destroy",
     "test/rails_root/script/generate",
     "test/rails_root/script/performance/benchmarker",
     "test/rails_root/script/performance/profiler",
     "test/rails_root/script/performance/request",
     "test/rails_root/script/plugin",
     "test/rails_root/script/process/inspector",
     "test/rails_root/script/process/reaper",
     "test/rails_root/script/process/spawner",
     "test/rails_root/script/runner",
     "test/rails_root/script/server",
     "test/rails_root/test/factories.rb",
     "test/rails_root/test/fixtures/files/5k.png",
     "test/rails_root/test/fixtures/files/IT'sUPPERCASE!AND WeIRD.JPG",
     "test/rails_root/test/functional/.keep",
     "test/rails_root/test/functional/uploads_controller_test.rb",
     "test/rails_root/test/integration/.keep",
     "test/rails_root/test/mocks/development/.keep",
     "test/rails_root/test/mocks/test/.keep",
     "test/rails_root/test/shoulda_macros/paperclip.rb",
     "test/rails_root/test/test_helper.rb",
     "test/rails_root/test/unit/.keep",
     "test/rails_root/test/unit/upload_test.rb",
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
    "test/rails_root/app/controllers/application_controller.rb",
     "test/rails_root/app/controllers/uploads_controller.rb",
     "test/rails_root/app/models/upload.rb",
     "test/rails_root/app/models/user.rb",
     "test/rails_root/config/boot.rb",
     "test/rails_root/config/environment.rb",
     "test/rails_root/config/environments/development.rb",
     "test/rails_root/config/environments/production.rb",
     "test/rails_root/config/environments/test.rb",
     "test/rails_root/config/initializers/inflections.rb",
     "test/rails_root/config/initializers/mime_types.rb",
     "test/rails_root/config/initializers/requires.rb",
     "test/rails_root/config/initializers/s3_credentials.rb",
     "test/rails_root/config/initializers/session_store.rb",
     "test/rails_root/config/initializers/uploader.rb",
     "test/rails_root/config/routes.rb",
     "test/rails_root/db/migrate/20090517040220_create_uploads.rb",
     "test/rails_root/db/migrate/20090602041838_create_users.rb",
     "test/rails_root/db/schema.rb",
     "test/rails_root/features/step_definitions/webrat_steps.rb",
     "test/rails_root/features/support/env.rb",
     "test/rails_root/public/dispatch.rb",
     "test/rails_root/script/create_project.rb",
     "test/rails_root/test/factories.rb",
     "test/rails_root/test/functional/uploads_controller_test.rb",
     "test/rails_root/test/shoulda_macros/paperclip.rb",
     "test/rails_root/test/test_helper.rb",
     "test/rails_root/test/unit/upload_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mime-types>, [">= 0"])
      s.add_runtime_dependency(%q<rack>, [">= 0"])
    else
      s.add_dependency(%q<mime-types>, [">= 0"])
      s.add_dependency(%q<rack>, [">= 0"])
    end
  else
    s.add_dependency(%q<mime-types>, [">= 0"])
    s.add_dependency(%q<rack>, [">= 0"])
  end
end
