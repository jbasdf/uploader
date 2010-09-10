require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase

  context "user" do
        
    context 'user instance' do
      setup do
        @user = Factory(:user)
      end
      
      should have_many :uploads

      should 'be able to upload' do
        assert @user.can_upload?(@user)
      end

      should 'not have methods from uploader mixin' do
        assert !defined?(User.is_public)
        assert !defined?(@user.is_image?)
      end
 
    end

  end
end