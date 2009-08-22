module UploaderHelper

  # Output a form capable of uploading files to the server.
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

  def new_upload_path_with_session_information(upload_parent, format = 'js')
    session_key = ActionController::Base.session_options[:key]
    swfupload_uploads_path({:format => format, session_key => cookies[session_key], request_forgery_protection_token => form_authenticity_token}.merge(make_parent_params(upload_parent)))
  end
  
  def make_parent_params(parent)
    { :parent_id => parent.id, :parent_type => parent.class.to_s }
  end
 
end