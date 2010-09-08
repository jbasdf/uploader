require File.dirname(__FILE__) + '/../test_helper'

class DefaultControllerTest < ActionController::TestCase

  tests DefaultController

  context "default controller" do
    
    context 'on GET to index' do
      # The default view calls the upload_form helper.  This isn't a great test but
      # it will make sure it doesn't blow up
      setup do
        @user = Factory(:user)
        get :index, :user_id => @user.to_param
      end
      should respond_with :success
      should "have a_container_with_a_long_name in the body" do
        assert @response.body.include?('a_container_with_a_long_name')
      end
      should "have '1 MB' in the body" do
        assert @response.body.include?('1 MB')
      end
      should "have '*.jpg' in the body" do
        assert @response.body.include?('*.jpg')
      end
    end

    context 'on GET to uploadify' do
      # The default view calls the upload_form helper.  This isn't a great test but
      # it will make sure it doesn't blow up
      setup do
        @user = Factory(:user)
        get :uploadify, :user_id => @user.to_param
      end
      should respond_with :success
      should "have a_container_with_a_long_name in the body" do
        assert @response.body.include?('a_container_with_a_long_name')
      end
      should "have '1310720' in the body" do
        assert @response.body.include?('1310720')
      end
      should "have '*.jpg' in the body" do
        assert @response.body.include?('*.jpg')
      end
    end
    
  end

end
