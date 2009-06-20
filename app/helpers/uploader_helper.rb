module UploaderHelper

  # parent is the object to which the uploads will be attached
  def upload_form(parent, display_upload_indicators = true)
    render :partial => 'uploads/swf_upload', :locals => {:parent => parent, :display_upload_indicators => display_upload_indicators}
  end

  def new_upload_path_with_session_information(upload_parent, format = 'js')
    session_key = ActionController::Base.session_options[:key]
    swfupload_uploads_path({:format => format, session_key => cookies[session_key], request_forgery_protection_token => form_authenticity_token}.merge(make_parent_params(upload_parent)))
  end
  
  def make_parent_params(parent)
    { :parent_id => parent.id, :parent_type => parent.class.to_s }
  end
 
end