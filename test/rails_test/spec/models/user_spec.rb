require File.dirname(__FILE__) + '/../spec_helper'

describe User do
        
  before do
    @user = Factory(:user)
  end
  
  it { should have_many :uploads }

  it 'should be able to upload' do
    @user.can_upload?(@user).should be_true
  end

  it 'should not have methods from uploader mixin' do
    assert !defined?(User.is_public)
    assert !defined?(@user.is_image?)
  end

end