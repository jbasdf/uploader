class Uploader::UploadsController < ApplicationController

  session :cookie_only => false, :only => :swfupload

  before_filter :get_parent, :only => [:create, :swfupload]
  
  def create
    
    # Standard, one-at-a-time, upload action
    @upload = @parent.uploads.build(params[:upload])
    @upload.user = current_user
    @upload.save!
    message = t('uploader.successful_upload')
    upload_json = basic_uploads_json(@upload)
    
    respond_to do |format|

      format.html do
        flash[:notice] = message
        redirect_to get_redirect
      end
            
      format.js do
        responds_to_parent do
          render :update do |page|
            page << "upload_file_callback('#{upload_json}');"
          end
        end
      end
      
    end
  rescue => ex
    message = _("An error occured while uploading the file: %{error}.  Please ensure that the file is valid.  
      Checkt to make sure the file is not empty.  Then try again." % {:error => ex})
    #message = _("An error occured while uploading the file.  Please try again.")
    respond_to do |format|
      format.html do
        flash[:notice] = message
        redirect_to get_redirect
      end
      format.js do
        responds_to_parent do
          render :update do |page|
            page << "upload_file_fail_callback('#{message}');"
          end
        end
      end
      #format.js { render :text => message }
    end
  end

  def swfupload
    # swfupload action set in routes.rb
    @upload = Upload.new
    @upload.is_public = true if params[:is_public] == true
    @upload.user = current_user
    @upload.swfupload_file = params[:Filedata]
    @upload.save!
    
    @parent.uploads << @upload

    respond_to do |format|
      format.json do
        render :text => @upload.to_json(:only => [:id, :data_file_name], :methods => [:icon])
      end
      format.js do
        # return a table row
        case @parent
        when User
          render :partial => 'uploads/upload_row', :object => @upload, :locals => {:style => 'style="display:none;"', :parent => @parent, :share => true}
        when Group  
          render :partial => 'uploads/upload_row', :object => @upload, :locals => {:style => 'style="display:none;"', :parent => @parent}
        else
          raise 'not implemented'
        end
      end
    end
  rescue => ex
    render :text => t("uploader.file_upload_error")
  end

  def destroy

    @upload = Upload.find(params[:id])
    @parent = @upload.uploadable # set this for redirect
    
    if @upload.can_edit?(current_user)
      @upload.destroy 
      msg = t('uploader.file_deleted')
    else
      msg = t("uploader.file_delete_permission_denied")
    end
    
    respond_to do |format|
      format.html do
        flash[:notice] = msg
        redirect_back_or_default(get_redirect)
      end
      format.js { render :text => msg }
    end
  
  end
    
  protected
  
  def permission_denied
    msg = t("uploader.permission_denied")
    respond_to do |format|
      format.html do
        flash[:notice] = msg
        redirect_to get_redirect
      end
      format.js do
        render :text => msg
      end
    end
  end

  def get_redirect
    case @parent
    when User
      user_uploads_path(@parent)
    when Site
      if is_admin?
        uploads_path(@parent)
      else
        user_uploads_path(current_user)
      end
    when Group
      group_uploads_path(@parent)
    else
      # by default just go back to the user's uploads page
      user_uploads_path(current_user)
    end
  end
  
  def get_parent
    if !params[:parent_type] || !params[:parent_id]
      raise t('uploader.missing_parent_id_error')
      return
    end
    @klass = params[:parent_type].to_s.capitalize.constantize
    @parent = @klass.find(params[:parent_id])
    unless has_permission_to_upload(current_user, @parent)
      permission_denied
    end
  end
  
  def has_permission_to_upload(user, upload_parent)
    true
  end
  
end