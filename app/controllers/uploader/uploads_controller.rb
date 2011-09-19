class Uploader::UploadsController < ApplicationController
  unloadable
  
  before_filter :setup_parent, :only => [:create, :multiupload]
  before_filter :filter_permissions, :only => [:create, :multiupload]
  before_filter :set_upload_for_destroy, :only => [:destroy]
 
  def create
    # Standard, one-at-a-time, upload action       
    if request.env['HTTP_X_FILE_UPLOAD'] == 'true'        
      tempfile = Tempfile.new(request.env['HTTP_X_FILE_NAME'], Uploader.configuration.temp_dir)
      tempfile << request.env['rack.input'].read
      tempfile.flush
      tempfile.rewind
      @upload = Upload.new(:name => request.env['HTTP_X_FILE_NAME'], :hard_file_name => request.env['HTTP_X_FILE_NAME'])
      # NOTE hard_file_name MUST be set before setting local or paperclip will process the file before the hard_file_name is set
      @upload.local = tempfile
    else
      @upload = Upload.new(params[:upload])
    end    
    @upload.uploadable = @parent
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
      format.json do
        if Uploader.configuration.use_http_status_failures
          render :json => message, :status => :unprocessable_entity
        else
          render :json => { :success => false, :message => message }
        end
      end
    end
  end

  def multiupload
    @upload = Upload.new
    @upload.is_public = true if params[:is_public] == true
    @upload.creator = get_creator
    @upload.uploadable = @parent
    @upload.multiupload_local = params[:Filedata]
    @upload.save!
    respond_to do |format|
      format.js { render :text => get_upload_text(@upload) }
      format.json { render :json => basic_uploads_json(@upload) }
    end
  rescue => ex
    message = t('uploader.standard_file_upload_error', :error => ex)
    respond_to do |format|
      format.js { render :text => message }
      format.json do
        if Uploader.configuration.use_http_status_failures
          render :json => message, :status => :unprocessable_entity
        else
          render :json => { :success => false, :message => message }
        end
      end
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
      format.json do
        if Uploader.configuration.use_http_status_failures
          if success
            render :json => message
          else
            render :json => message, :status => :unprocessable_entity
          end
        else
          render :json => { :success => success, :message => message }
        end
      end
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
    def setup_parent(*ignore)
      @parent = get_parent(ignore)
      @parent = get_creator if @parent.blank?
      # if @parent.blank?
      #   render :text => t('muck.engine.missing_parent_error')
      #   return false
      # end
    end
  
    # Tries to get parent using parent_type and parent_id from the url.
    # If that fails and attempt is then made using find_parent
    # parameters:
    # ignore: Names to ignore.  For example if the url is /foo/1/bar?thing_id=1
    #         you might want to ignore thing_id so pass :thing.
    def get_parent(*ignore)
      if params[:parent_type].blank? || params[:parent_id].blank?
        find_parent(ignore)
      else
        klass = params[:parent_type].to_s.constantize
        klass.find(params[:parent_id])
      end
    end
  
    # Searches the params to try and find an entry ending with _id
    # ie article_id, user_id, etc.  Will return the first value found.
    # parameters:
    # ignore: Names to ignore.  For example if the url is /foo/1/bar?thing_id=1
    #         you might want to ignore thing_id so pass 'thing' to be ignored.
    def find_parent(*ignore)
      ignore.flatten!
      params.each do |name, value|
        if name =~ /(.+)_id$/
          if !ignore.include?($1)
            return $1.classify.constantize.find(value)
          end
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
      return true if upload_parent.blank? # upload will not be connected with a parent object only with the user
      upload_parent.can_upload?(user)
    end

    def basic_uploads_json(upload)
      upload.as_json(:only => [:id], :methods => [:icon, :thumb, :file_name])
    end

end