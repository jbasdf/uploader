# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{uploader}
  s.version = "3.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin Ball", "Joel Duffin", "David South"]
  s.date = %q{2011-09-17}
  s.description = %q{Uploader gem that makes it simple add multiple file uploads to your Rails project using SWFUpload, Uploadify and Paperclip}
  s.email = %q{justinball@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc",
    "TODO"
  ]
  s.files = [
    "MIT-LICENSE",
    "README.rdoc",
    "Rakefile",
    "TODO",
    "VERSION",
    "app/controllers/uploader/uploads_controller.rb",
    "app/helpers/uploader_helper.rb",
    "app/views/uploads/_swf_javascript.html.erb",
    "app/views/uploads/_swf_upload.html.erb",
    "app/views/uploads/_uploadify.html.erb",
    "config/locales/ar.yml",
    "config/locales/bg.yml",
    "config/locales/ca.yml",
    "config/locales/cs.yml",
    "config/locales/da.yml",
    "config/locales/de.yml",
    "config/locales/el.yml",
    "config/locales/en.yml",
    "config/locales/es.yml",
    "config/locales/et.yml",
    "config/locales/fa.yml",
    "config/locales/fi.yml",
    "config/locales/fr.yml",
    "config/locales/gl.yml",
    "config/locales/hi.yml",
    "config/locales/hr.yml",
    "config/locales/hu.yml",
    "config/locales/id.yml",
    "config/locales/it.yml",
    "config/locales/iw.yml",
    "config/locales/ja.yml",
    "config/locales/ko.yml",
    "config/locales/lt.yml",
    "config/locales/lv.yml",
    "config/locales/mt.yml",
    "config/locales/nl.yml",
    "config/locales/no.yml",
    "config/locales/pl.yml",
    "config/locales/pt-PT.yml",
    "config/locales/ro.yml",
    "config/locales/ru.yml",
    "config/locales/sk.yml",
    "config/locales/sl.yml",
    "config/locales/sq.yml",
    "config/locales/sr.yml",
    "config/locales/sv.yml",
    "config/locales/th.yml",
    "config/locales/tl.yml",
    "config/locales/tr.yml",
    "config/locales/uk.yml",
    "config/locales/vi.yml",
    "config/locales/zh-CN.yml",
    "config/locales/zh-TW.yml",
    "config/locales/zh.yml",
    "config/routes.rb",
    "db/migrate/20090517040220_create_uploads.rb",
    "lib/daemons/amazonaws.rb",
    "lib/tasks/uploader.rake",
    "lib/uploader.rb",
    "lib/uploader/config.rb",
    "lib/uploader/engine.rb",
    "lib/uploader/exceptions.rb",
    "lib/uploader/middleware/flash_session_cookie_middleware.rb",
    "lib/uploader/mime_type_groups.rb",
    "lib/uploader/models/upload.rb",
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
    "public/images/swfupload/SWFUploadButton.png",
    "public/images/swfupload/cancelbutton.gif",
    "public/images/uploadify/cancel.png",
    "public/javascripts/jquery/jquery.uploadify.min.js",
    "public/javascripts/swf/swfobject.js",
    "public/javascripts/swfupload/fileprogress.js",
    "public/javascripts/swfupload/handlers.js",
    "public/javascripts/swfupload/swfupload.cookies.js",
    "public/javascripts/swfupload/swfupload.js",
    "public/javascripts/swfupload/swfupload.proxy.js",
    "public/javascripts/swfupload/swfupload.queue.js",
    "public/javascripts/swfupload/swfupload.speed.js",
    "public/javascripts/swfupload/swfupload.swfobject.js",
    "public/stylesheets/swfupload.css",
    "public/stylesheets/uploadify.css",
    "public/swf/expressInstall.swf",
    "public/swf/swfupload.swf",
    "public/swf/swfupload_fp9.swf",
    "public/swf/uploadify.swf",
    "test/rails_test/.gitignore",
    "test/rails_test/.rake_tasks",
    "test/rails_test/Gemfile",
    "test/rails_test/Gemfile.lock",
    "test/rails_test/README",
    "test/rails_test/Rakefile",
    "test/rails_test/app/controllers/application_controller.rb",
    "test/rails_test/app/controllers/default_controller.rb",
    "test/rails_test/app/controllers/uploads_controller.rb",
    "test/rails_test/app/models/.keep",
    "test/rails_test/app/models/upload.rb",
    "test/rails_test/app/models/user.rb",
    "test/rails_test/app/views/default/index.html.erb",
    "test/rails_test/app/views/default/uploadify.html.erb",
    "test/rails_test/app/views/layouts/application.html.erb",
    "test/rails_test/config.ru",
    "test/rails_test/config/amazon_s3.yml",
    "test/rails_test/config/application.rb",
    "test/rails_test/config/boot.rb",
    "test/rails_test/config/database.yml",
    "test/rails_test/config/environment.rb",
    "test/rails_test/config/environments/development.rb",
    "test/rails_test/config/environments/production.rb",
    "test/rails_test/config/environments/test.rb",
    "test/rails_test/config/initializers/backtrace_silencers.rb",
    "test/rails_test/config/initializers/inflections.rb",
    "test/rails_test/config/initializers/mime_types.rb",
    "test/rails_test/config/initializers/s3_credentials.rb",
    "test/rails_test/config/initializers/secret_token.rb",
    "test/rails_test/config/initializers/session_store.rb",
    "test/rails_test/config/locales/en.yml",
    "test/rails_test/config/routes.rb",
    "test/rails_test/db/.keep",
    "test/rails_test/db/migrate/20090517040220_create_uploads.rb",
    "test/rails_test/db/migrate/20090602041838_create_users.rb",
    "test/rails_test/db/seeds.rb",
    "test/rails_test/doc/README_FOR_APP",
    "test/rails_test/features/step_definitions/webrat_steps.rb",
    "test/rails_test/features/support/env.rb",
    "test/rails_test/lib/daemons/amazonaws.rb",
    "test/rails_test/lib/tasks/.gitkeep",
    "test/rails_test/public/404.html",
    "test/rails_test/public/422.html",
    "test/rails_test/public/500.html",
    "test/rails_test/public/favicon.ico",
    "test/rails_test/public/images/file_icons/excel.gif",
    "test/rails_test/public/images/file_icons/file.gif",
    "test/rails_test/public/images/file_icons/file.png",
    "test/rails_test/public/images/file_icons/file_aac.gif",
    "test/rails_test/public/images/file_icons/file_ai.gif",
    "test/rails_test/public/images/file_icons/file_avi.gif",
    "test/rails_test/public/images/file_icons/file_bin.gif",
    "test/rails_test/public/images/file_icons/file_bmp.gif",
    "test/rails_test/public/images/file_icons/file_cue.gif",
    "test/rails_test/public/images/file_icons/file_divx.gif",
    "test/rails_test/public/images/file_icons/file_doc.gif",
    "test/rails_test/public/images/file_icons/file_eps.gif",
    "test/rails_test/public/images/file_icons/file_flac.gif",
    "test/rails_test/public/images/file_icons/file_flv.gif",
    "test/rails_test/public/images/file_icons/file_gif.gif",
    "test/rails_test/public/images/file_icons/file_html.gif",
    "test/rails_test/public/images/file_icons/file_ical.gif",
    "test/rails_test/public/images/file_icons/file_indd.gif",
    "test/rails_test/public/images/file_icons/file_inx.gif",
    "test/rails_test/public/images/file_icons/file_iso.gif",
    "test/rails_test/public/images/file_icons/file_jpg.gif",
    "test/rails_test/public/images/file_icons/file_mov.gif",
    "test/rails_test/public/images/file_icons/file_mp3.gif",
    "test/rails_test/public/images/file_icons/file_mpg.gif",
    "test/rails_test/public/images/file_icons/file_pdf.gif",
    "test/rails_test/public/images/file_icons/file_php.gif",
    "test/rails_test/public/images/file_icons/file_png.gif",
    "test/rails_test/public/images/file_icons/file_pps.gif",
    "test/rails_test/public/images/file_icons/file_ppt.gif",
    "test/rails_test/public/images/file_icons/file_psd.gif",
    "test/rails_test/public/images/file_icons/file_qxd.gif",
    "test/rails_test/public/images/file_icons/file_qxp.gif",
    "test/rails_test/public/images/file_icons/file_raw.gif",
    "test/rails_test/public/images/file_icons/file_rtf.gif",
    "test/rails_test/public/images/file_icons/file_svg.gif",
    "test/rails_test/public/images/file_icons/file_tif.gif",
    "test/rails_test/public/images/file_icons/file_txt.gif",
    "test/rails_test/public/images/file_icons/file_vcf.gif",
    "test/rails_test/public/images/file_icons/file_wav.gif",
    "test/rails_test/public/images/file_icons/file_wma.gif",
    "test/rails_test/public/images/file_icons/file_xls.gif",
    "test/rails_test/public/images/file_icons/file_xml.gif",
    "test/rails_test/public/images/file_icons/mp3.gif",
    "test/rails_test/public/images/file_icons/pdf.gif",
    "test/rails_test/public/images/file_icons/pdf.png",
    "test/rails_test/public/images/file_icons/text.gif",
    "test/rails_test/public/images/file_icons/text.png",
    "test/rails_test/public/images/file_icons/word.gif",
    "test/rails_test/public/images/rails.png",
    "test/rails_test/public/images/swfupload/SWFUploadButton.png",
    "test/rails_test/public/images/swfupload/cancelbutton.gif",
    "test/rails_test/public/images/uploadify/cancel.png",
    "test/rails_test/public/javascripts/application.js",
    "test/rails_test/public/javascripts/controls.js",
    "test/rails_test/public/javascripts/dragdrop.js",
    "test/rails_test/public/javascripts/effects.js",
    "test/rails_test/public/javascripts/jquery/jquery-1.4.2.min.js",
    "test/rails_test/public/javascripts/jquery/jquery-ui-1.8.4.custom.min.js",
    "test/rails_test/public/javascripts/jquery/jquery.uploadify.min.js",
    "test/rails_test/public/javascripts/prototype.js",
    "test/rails_test/public/javascripts/rails.js",
    "test/rails_test/public/javascripts/swf/swfobject.js",
    "test/rails_test/public/javascripts/swfupload/fileprogress.js",
    "test/rails_test/public/javascripts/swfupload/handlers.js",
    "test/rails_test/public/javascripts/swfupload/swfupload.cookies.js",
    "test/rails_test/public/javascripts/swfupload/swfupload.js",
    "test/rails_test/public/javascripts/swfupload/swfupload.proxy.js",
    "test/rails_test/public/javascripts/swfupload/swfupload.queue.js",
    "test/rails_test/public/javascripts/swfupload/swfupload.speed.js",
    "test/rails_test/public/javascripts/swfupload/swfupload.swfobject.js",
    "test/rails_test/public/robots.txt",
    "test/rails_test/public/stylesheets/.gitkeep",
    "test/rails_test/public/stylesheets/swfupload.css",
    "test/rails_test/public/stylesheets/uploadify.css",
    "test/rails_test/public/swf/expressInstall.swf",
    "test/rails_test/public/swf/swfupload.swf",
    "test/rails_test/public/swf/swfupload_fp9.swf",
    "test/rails_test/public/swf/uploadify.swf",
    "test/rails_test/script/rails",
    "test/rails_test/spec/controllers/default_controller_spec.rb",
    "test/rails_test/spec/controllers/uploads_controller_spec.rb",
    "test/rails_test/spec/factories.rb",
    "test/rails_test/spec/fixtures/files/5k.png",
    "test/rails_test/spec/fixtures/files/IT'sUPPERCASE!AND WeIRD.JPG",
    "test/rails_test/spec/fixtures/rails.png",
    "test/rails_test/spec/fixtures/test.doc",
    "test/rails_test/spec/fixtures/test.pdf",
    "test/rails_test/spec/fixtures/test.txt",
    "test/rails_test/spec/fixtures/test.xls",
    "test/rails_test/spec/models/upload_spec.rb",
    "test/rails_test/spec/models/user_spec.rb",
    "test/rails_test/spec/spec_helper.rb",
    "uninstall.rb",
    "uploader.gemspec"
  ]
  s.homepage = %q{http://github.com/jbasdf/uploader}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Uploadify, SWFUpload + Paperclip wrapped in an engine with love.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mime-types>, [">= 0"])
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_runtime_dependency(%q<paperclip>, [">= 0"])
      s.add_runtime_dependency(%q<aws-s3>, [">= 0"])
    else
      s.add_dependency(%q<mime-types>, [">= 0"])
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<paperclip>, [">= 0"])
      s.add_dependency(%q<aws-s3>, [">= 0"])
    end
  else
    s.add_dependency(%q<mime-types>, [">= 0"])
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<paperclip>, [">= 0"])
    s.add_dependency(%q<aws-s3>, [">= 0"])
  end
end

