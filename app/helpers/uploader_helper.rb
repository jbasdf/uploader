module UploaderHelper

  # parent is the object to which the uploads will be attached
  def upload_form(parent)
    render :partial => 'uploads/swf_upload', :locals => {:parent => parent}
  end

  def new_upload_path_with_session_information(upload_parent)
    session_key = ActionController::Base.session_options[:key]
    swfupload_uploads_path({session_key => cookies[session_key], request_forgery_protection_token => form_authenticity_token}.merge(make_parent_params(upload_parent)))
  end
  
  def make_parent_params(parent)
    { :parent_id => parent.id, :parent_type => parent.class.to_s }
  end
 
end