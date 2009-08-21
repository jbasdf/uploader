class Uploader::UploadsController < ApplicationController
  unloadable
  
  before_filter :setup_parent, :only => [:create, :swfupload]
  before_filter :filter_permissions, :only => [:create, :swfupload]
  before_filter :set_upload_for_destroy, :only => [:destroy]
 
  def create
    # Standard, one-at-a-time, upload action
    @upload = @parent.uploads.build(params[:upload])
    @upload.creator = get_creator
    @upload.save!
    message = t('uploader.successful_upload')
    upload_json = basic_uploads_json(@upload)

    respond_to do |format|
      format.html do
        flash[:notice] = message
        redirect_to get_redirect(:create_success)
      end
      format.js { render :text => get_upload_text(@upload) }
      format.json { render :json => upload_json }
    end
  rescue => ex
    message = t('uploader.standard_file_upload_error', :error => ex)
    respond_to do |format|
      format.html do
        flash[:notice] = message
        redirect_to get_redirect(:create_failure)
      end
      format.js { render :text => message }
      format.json { render :json => { :success => false, :message => message } }
    end
  end

  def swfupload
    @upload = @parent.uploads.build
    @upload.is_public = true if params[:is_public] == true
    @upload.creator = get_creator
    @upload.swfupload_local = params[:Filedata]
    @upload.save!
    @parent.uploads << @upload
    respond_to do |format|
      format.js { render :text => get_upload_text(@upload) }
      format.json { render :json => basic_uploads_json(@upload) }
    end
  rescue => ex
    message = t('uploader.standard_file_upload_error', :error => ex)
    respond_to do |format|
      format.js { render :text => message }
      format.json { render :json => { :success => false, :message => message } }
    end
  end

  def destroy
    @parent = @upload.uploadable # set this for redirect
    if @upload.can_edit?(current_user)
      @upload.destroy
      message = t('uploader.file_deleted')
      success = true
    else
      message = t("uploader.file_delete_permission_denied")
      success = false
    end
    respond_to do |format|
      format.html do
        flash[:notice] = message
        redirect_to get_redirect(:destroy_success)
      end
      format.js { render :text => message }
      format.json { render :json => { :success => success, :message => message } }
    end
  end

  protected

  def get_upload_text(upload)
    raise 'implement get_upload_text in your controller'
  end

  def set_upload_for_destroy
    @upload = Upload.find(params[:id])
  end

  def permission_denied
    message = t("uploader.permission_denied")
    respond_to do |format|
      format.html do
        flash[:notice] = message
        redirect_to get_redirect(:permission_denied)
      end
      format.js { render :text => message }
      format.json { render :json => { :success => false, :message => message } }
    end
  end

  # override this method in your controller to set the redirect file upload completion
  # source can be :destroy_success, :create_success, :create_failure, :permission_denied
  def get_redirect(source)
    @parent
  end

  # Attempts to create an @parent object using params
  # or the url.
  def setup_parent
    @parent = get_parent
    if @parent.blank?
      render :text => t('muck.engine.missing_parent_error')
      return false
    end
  end
  
  # Tries to get parent using parent_type and parent_id from the url.
  # If that fails and attempt is then made using find_parent
  def get_parent
    if params[:parent_type].blank? || params[:parent_id].blank?
      find_parent
    else
      klass = params[:parent_type].to_s.constantize
      klass.find(params[:parent_id])
    end
  end

  # Searches the params to try and find an entry ending with _id
  # ie article_id, user_id, etc.  Will return the first value found.
  def find_parent
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def filter_permissions 
    unless has_permission_to_upload(current_user, @parent)
      permission_denied
    end
  end

  def get_creator
    current_user
  end
  
  def has_permission_to_upload(user, upload_parent)
    upload_parent.can_upload?(user)
  end

  def basic_uploads_json(upload)
    upload.to_json(:only => [:id, :file_name], :methods => [:icon])
  end

end