module UploaderHelper

  def upload_form
    render :partial => 'uploads/swf_upload'
  end

  def new_upload_path_with_session_information(upload_parent)
    session_key = ActionController::Base.session_options[:key]
    swfupload_uploads_path(session_key => cookies[session_key], :type => upload_parent.class.to_s, :id => upload_parent.id)    
  end
  
end