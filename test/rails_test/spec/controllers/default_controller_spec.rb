require File.dirname(__FILE__) + '/../spec_helper'

describe DefaultController do
  
  render_views
      
  describe 'on GET to index' do
    # The default view calls the upload_form helper.  This isn't a great test but
    # it will make sure it doesn't blow up
    before do
      @user = Factory(:user)
      get :index, :user_id => @user.to_param
    end
    it { should respond_with :success }
    it "should have a_container_with_a_long_name in the body" do
      @response.body.should include('a_container_with_a_long_name')
    end
    it "should have '1 MB' in the body" do
      @response.body.should include('1 MB')
    end
    it "should have '*.jpg' in the body" do
      @response.body.should include('*.jpg')
    end
  end

  describe 'on GET to uploadify' do
    # The default view calls the upload_form helper.  This isn't a great test but
    # it will make sure it doesn't blow up
    before do
      @user = Factory(:user)
      get :uploadify, :user_id => @user.to_param
    end
    it { should respond_with :success }
    it "should have a_container_with_a_long_name in the body" do
      @response.body.should include('a_container_with_a_long_name')
    end
    it "should have '1310720' in the body" do
      @response.body.should include('1310720')
    end
    it "should have '*.jpg' in the body" do
      @response.body.should include('*.jpg')
    end
  end
    
end
