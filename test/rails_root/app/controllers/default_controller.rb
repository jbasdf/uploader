class DefaultController < ApplicationController
  
  def index
    @user = User.find(params[:user_id]) rescue User.new
  end
  
  def uploadify
    @user = User.find(params[:user_id]) rescue User.new
  end
  
  
end