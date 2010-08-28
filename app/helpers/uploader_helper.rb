module UploaderHelper

  # Output a form capable of uploading files to the server using swfupload.
  # parent: The object to which the uploads will be attached
  # display_upload_indicators: Indicates whether or not to show the upload progress
  # container_prefix: Prefixes each id in the html with the specified text.  Useful if there is to be more than one form on a page.
  # options: Options to pass to the swf javascript for setting up the swfupload object:
  #     upload_url:             Url to upload to.  Default is '<%= new_upload_path_with_session_information(parent) %>'
  #     file_size_limit:        Largest allowable file size.  Default is '100 MB'
  #     file_types:             Allowed file types.  Default is "*.*"
  #     file_types_description: Description for file types.  Default is "All Files"
  #     file_upload_limit:      Maximum number of files per upload.  Default is 100
  #     button_image_url:       Url of button image to use for swf upload.  Default is "/images/SWFUploadButton.png"
  #     button_width:           Width of the image button being used.  Default is 61
  #     button_height:          Height of the button being used.  Default is 22
  #     transparent:            Turns the swfupload transparent so you can use the html behind it for the upload button.  
  #                             This will override any settings provided for button_image_url
  #     transparent_html:       If transparent is true this html will be rendered under the transparent swfupload button.
  def upload_form(parent, display_upload_indicators = true, container_prefix = '', options = {})
    render :partial => 'uploads/swf_upload', :locals => {:parent => parent, 
                                                         :display_upload_indicators => display_upload_indicators, 
                                                         :container_prefix => container_prefix, 
                                                         :options => options}
  end

  # Output a form capable of uploading multiple files to the server using uploadify.
  # parent: The object to which the uploads will be attached
  # display_upload_indicators: Indicates whether or not to show the upload progress
  # container_prefix: Prefixes each id in the html with the specified text.  Useful if there is to be more than one form on a page.
  # Options is a hash containing any valid option for uploadify:
  # http://www.uploadify.com/documentation/
  def uploadify_form(parent, display_upload_indicators = true, container_prefix = '', options = {})
    container_prefix = 'uploadify' if container_prefix.blank?
    
    uploadify_options = {
          :uploader        => '/swf/uploadify.swf',
          :script          => new_upload_path_with_parent_information(parent),
          :cancelImg       => '/images/uploadify/cancel.png',
          :fileDesc        => "All Files",
          :fileExt         => "*.*",
          :auto            => true,
          :sizeLimit       => 13107200, # 100 MB
          :multi           => true,
          :buttonText      => 'Upload',
          :scriptData      => {
            '_http_accept'       => 'application/javascript',
            "#{get_session_key}" => "encodeURIComponent('#{u cookies[get_session_key]}')",
            'authenticity_token' => "encodeURIComponent('#{u form_authenticity_token}')"
          }
      }.merge(options)

      # onComplete      : function(a, b, c, response){ eval(response); $('#<%= "#{container_prefix}_queue" %>').html(''); },
      # queueID         : 'noQueueForMePlease',
      # onProgress      : function(event, queueID, fileObj, data){ $('#<%= "#{container_prefix}_queue" %>').html(data.percentage + '%') },
    	#buttonImg : '<%= options[:button_image_url] || "/images/swfupload/SWFUploadButton.png" %>'
      
    render :partial => 'uploads/uploadify', :locals => { :parent => parent,
                                                         :container_prefix => container_prefix,
                                                         :uploadify_options => uploadify_options.to_json}
  end
  
  def new_upload_path_with_session_information(upload_parent, format = 'js')
    multiupload_uploads_path({:format => format, :session_key => cookies[get_session_key], :request_forgery_protection_token => form_authenticity_token}.merge(make_parent_params(upload_parent)))
  end
  
  def new_upload_path_with_parent_information(upload_parent, format = 'js')
    multiupload_uploads_path({:format => format}.merge(make_parent_params(upload_parent)))
  end
  
  def get_session_key
    if defined?(Rails.application)
      Rails.application.config.session_options[:key]
    else
      ActionController::Base.session_options[:key]
    end
  end
  
  def make_parent_params(parent)
    return {} if parent.blank?
    { :parent_id => parent.id, :parent_type => parent.class.to_s }
  end
 
  # Outputs a link that will show the degraded container.  Use if users are having problems with the Flash uploader
  def show_degraded_container_link
    %Q{<a class="show_degraded_container" href="#">#{I18n.t('uploader.show_degraded_container')}</a>}
  end
  
  # Outputs a link that will show the swfupload container
  def show_swfupload_container_link
    %Q{<a class="show_swfupload_container" style="display:none;" href="#">#{I18n.t('uploader.show_swfupload_container')}</a>}
  end
  
  
end