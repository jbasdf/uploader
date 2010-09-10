require File.dirname(__FILE__) + '/../test_helper'

class UploadsControllerTest < ActionController::TestCase

  def setup
    @controller = UploadsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @user = Factory(:user)
    @controller.stubs(:current_user).returns(@user)
  end

  context 'on POST to :create' do
    context "good file" do
      setup do
        post :create, { :upload => { :local => VALID_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
      end
      should redirect_to("/create_success") { '/create_success' }
      should set_the_flash.to(I18n.t('uploader.successful_upload'))
      should "create a valid upload" do
        assert_difference "@user.uploads.count", 1 do
          post :create, { :upload => { :local => VALID_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
        end
        assert assigns(:upload).errors.empty?, assigns(:upload).errors
      end
    end
    context "good text file" do
      setup do
        post :create, { :upload => { :local => VALID_TEXT_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
      end
      should redirect_to("/create_success") { '/create_success' }
      should set_the_flash.to(I18n.t('uploader.successful_upload'))
      should "create a valid upload" do
        assert_difference "@user.uploads.count", 1 do
          post :create, { :upload => { :local => VALID_TEXT_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
        end
        assert assigns(:upload).errors.empty?, assigns(:upload).errors
      end
    end
    context "good pdf file" do
      setup do
        post :create, { :upload => { :local => VALID_PDF_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
      end
      should redirect_to("/create_success") { '/create_success' }
      should set_the_flash.to(I18n.t('uploader.successful_upload'))
      should "create a valid upload" do
        assert_difference "@user.uploads.count", 1 do
          post :create, { :upload => { :local => VALID_PDF_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
        end
        assert assigns(:upload).errors.empty?, assigns(:upload).errors
      end
    end
    context "good doc file" do
      setup do
        post :create, { :upload => { :local => VALID_WORD_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
      end
      should redirect_to("/create_success") { '/create_success' }
      should set_the_flash.to(I18n.t('uploader.successful_upload'))
      should "create a valid upload" do
        assert_difference "@user.uploads.count", 1 do
          post :create, { :upload => { :local => VALID_WORD_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
        end
        assert assigns(:upload).errors.empty?, assigns(:upload).errors
      end
    end
    context "good excel file" do
      setup do
        post :create, { :upload => { :local => VALID_EXCEL_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
      end
      should redirect_to("/create_success") { '/create_success' }
      should set_the_flash.to(I18n.t('uploader.successful_upload'))
      should "create a valid upload" do
        assert_difference "@user.uploads.count", 1 do
          post :create, { :upload => { :local => VALID_EXCEL_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
        end
        assert assigns(:upload).errors.empty?, assigns(:upload).errors
      end
    end
    context "bad file" do
      setup do
        post :create, { :upload => { :local => nil }, :parent_type => 'User', :parent_id => @user.to_param }
      end
      should redirect_to("/create_failure") { '/create_failure' }
      should set_the_flash.to(/An error occured while uploading the file/)
      should "not create file" do
        assert_difference "@user.uploads.count", 1 do
          post :create, { :upload => { :local => VALID_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
        end
        assert assigns(:upload).errors.empty?, assigns(:upload).errors
      end
    end
  end
  context 'on POST to :multiupload' do
    context 'js' do
      setup do
        post :multiupload, { :Filedata => VALID_FILE, :parent_type => 'User', :parent_id => @user.to_param, :format => 'js' }
      end
      should respond_with :success
      should "add an upload" do
        assert_difference "Upload.count", 1 do
          post :multiupload, { :Filedata => VALID_FILE, :parent_type => 'User', :parent_id => @user.to_param, :format => 'js' }
        end
      end
    end
    context 'json' do
      setup do
        post :multiupload, { :Filedata => VALID_FILE, :parent_type => 'User', :parent_id => @user.to_param, :format => 'json' }
      end
      should respond_with :success
      should "add an upload" do
        assert_difference "Upload.count", 1 do
          post :multiupload, { :Filedata => VALID_FILE, :parent_type => 'User', :parent_id => @user.to_param, :format => 'json' }
        end
      end
    end
  end

  context 'permission denied' do
    setup do
      @controller.stubs(:has_permission_to_upload).returns(false)
      post :create, { :upload => { :local => VALID_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
    end
    should redirect_to("/permission_denied") { '/permission_denied' }
  end
  
  context 'on DELETE to :destroy' do
    setup do
      @upload = Factory(:upload)
    end
    context "has permission" do
      context "controller" do
        setup do
          delete :destroy, { :id => @upload.to_param }
        end
        should redirect_to("/destroy_success") { '/destroy_success' }
        should set_the_flash.to(I18n.t('uploader.file_deleted'))
      end
      context "data changes" do
        should "delete the upload" do
          assert_difference "Upload.count", -1 do
            delete :destroy, { :id => @upload.to_param }
          end
        end
      end
    end
    context "permission denied" do
      setup do
        @upload.stubs(:can_edit?).returns(false)
        Upload.stubs(:find).returns(@upload) # db version won't have can_edit? stubbed since it is a new object so we have to return @upload instead.
      end
      context "controller" do
        setup do
          delete :destroy, { :id => @upload.to_param }
        end
        should redirect_to("/destroy_success") { '/destroy_success' }
        should set_the_flash.to(I18n.t('uploader.file_delete_permission_denied'))
      end
      context "data changes" do
        should "not delete the upload" do
          assert_no_difference "Upload.count" do
            delete :destroy, { :id => @upload.to_param }
          end
        end
      end
    end
    
  end
  
end