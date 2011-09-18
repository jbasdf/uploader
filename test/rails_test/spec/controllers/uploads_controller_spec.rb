require File.dirname(__FILE__) + '/../spec_helper'

describe UploadsController do

  before do
    @user = Factory(:user)
    @controller.stub!(:current_user).and_return(@user)
  end

  describe 'on POST to :create' do
    describe "good file" do
      describe "response" do
        before do
          post :create, { :upload => { :local => VALID_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
        end
        it { should redirect_to("/create_success") }
        it { should set_the_flash.to(I18n.t('uploader.successful_upload')) }
      end
      it "should create a valid upload" do
        expect {
          post :create, { :upload => { :local => VALID_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
          assigns(:upload).errors.should be_empty
        }.to change(@user.uploads, :count).by(1)        
      end
    end
    describe "good text file" do
      describe "response" do
        before do
          post :create, { :upload => { :local => VALID_TEXT_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
        end
        it { should redirect_to("/create_success") }
        it { should set_the_flash.to(I18n.t('uploader.successful_upload')) }
      end
      it "should create a valid upload" do        
        expect {
          post :create, { :upload => { :local => VALID_TEXT_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
          assigns(:upload).errors.should be_empty
        }.to change(@user.uploads, :count).by(1)
      end
    end
    describe "good pdf file" do
      describe "response" do
        before do
          post :create, { :upload => { :local => VALID_PDF_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
        end
        it { should redirect_to("/create_success") }
        it { should set_the_flash.to(I18n.t('uploader.successful_upload')) }
      end
      it "should create a valid upload" do
        expect {
          post :create, { :upload => { :local => VALID_PDF_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
          assigns(:upload).errors.should be_empty
        }.to change(@user.uploads, :count).by(1)
      end
    end
    describe "good doc file" do
      describe "response" do
        before do
          post :create, { :upload => { :local => VALID_WORD_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
        end
        it { should redirect_to("/create_success") }
        it { should set_the_flash.to(I18n.t('uploader.successful_upload')) }
      end
      it "should create a valid upload" do
        expect {
          post :create, { :upload => { :local => VALID_WORD_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
          assigns(:upload).errors.should be_empty
        }.to change(@user.uploads, :count).by(1)
      end
    end
    describe "good excel file" do
      describe "response" do
        before do
          post :create, { :upload => { :local => VALID_EXCEL_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
        end
        it { should redirect_to("/create_success") }
        it { should set_the_flash.to(I18n.t('uploader.successful_upload')) }
      end
      it "should create a valid upload" do        
        expect {
          post :create, { :upload => { :local => VALID_EXCEL_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
          assigns(:upload).errors.should be_empty
        }.to change(@user.uploads, :count).by(1)
      end
    end
    describe "bad file" do
      describe "response" do
        before do
          post :create, { :upload => { :local => nil }, :parent_type => 'User', :parent_id => @user.to_param }
        end
        it { should redirect_to("/create_failure") }
        it { should set_the_flash.to(/An error occured while uploading the file/) }
      end
      it "should not create file" do        
        expect {
          post :create, { :upload => { :local => nil }, :parent_type => 'User', :parent_id => @user.to_param }
          assigns(:upload).errors.should_not be_empty
        }.to change(@user.uploads, :count).by(0)
      end
    end
    describe "raw file upload" do
      before do
        @name = 'rails.png'
        @request.set_header "HTTP_X_FILE_NAME", @name
        @request.set_header "HTTP_X_FILE_UPLOAD", "true"
        @request.set_header "rack.input", StringIO.new('some random file')       
      end
      it "should create a new upload" do
        expect {
          post :create
        }.to change(Upload, :count).by(1)
      end
      it "should not have errors on the upload" do
        post :create
        assert assigns(:upload).errors.empty?
      end
      it "should set the name of the file" do
        post :create
        assert assigns(:upload).name == @name
        assert assigns(:upload).local_file_name == @name
      end      
    end
  end
  describe 'on POST to :multiupload' do
    describe 'js' do
      describe "response" do
        before do
          post :multiupload, { :Filedata => VALID_FILE, :parent_type => 'User', :parent_id => @user.to_param, :format => 'js' }
        end
        it { should respond_with :success }
      end
      it "should add an upload" do
        expect {
          post :multiupload, { :Filedata => VALID_FILE, :parent_type => 'User', :parent_id => @user.to_param, :format => 'js' }
        }.to change(Upload, :count).by(1)
      end
    end
    describe 'json' do
      describe "response" do
        before do
          post :multiupload, { :Filedata => VALID_FILE, :parent_type => 'User', :parent_id => @user.to_param, :format => 'json' }
        end
        it { should respond_with :success }
      end
      it "should add an upload" do
        expect {
          post :multiupload, { :Filedata => VALID_FILE, :parent_type => 'User', :parent_id => @user.to_param, :format => 'json' }
        }.to change(Upload, :count).by(1)
      end
    end
  end

  describe 'permission denied' do
    before do
      @controller.stub!(:has_permission_to_upload).and_return(false)
      post :create, { :upload => { :local => VALID_FILE }, :parent_type => 'User', :parent_id => @user.to_param }
    end
    it {should redirect_to("/permission_denied") }
  end
  
  describe 'on DELETE to :destroy' do
    before do
      @upload = Factory(:upload)
    end
    describe "has permission" do
      describe "controller" do
        before do
          delete :destroy, { :id => @upload.to_param }
        end
        it {should redirect_to("/destroy_success")}
        it { should set_the_flash.to((I18n.t('uploader.file_deleted'))) }
      end
      describe "data changes" do
        it "should delete the upload" do
          expect {
            delete :destroy, { :id => @upload.to_param }
          }.to change(Upload, :count).by(-1)
        end
      end
    end
    describe "permission denied" do
      before do
        @upload.stub!(:can_edit?).and_return(false)
        Upload.stub!(:find).and_return(@upload) # db version won't have can_edit? stubbed since it is a new object so we have to return @upload instead.
      end
      describe "controller" do
        before do
          delete :destroy, { :id => @upload.to_param }
        end
        it {should redirect_to("/destroy_success")}
        it { should set_the_flash.to((I18n.t('uploader.file_delete_permission_denied'))) }
      end
      describe "data changes" do
        it "should not delete the upload" do
          expect {
            delete :destroy, { :id => @upload.to_param }
          }.to change(Upload, :count).by(0)
        end
      end
    end
    
  end
  
end