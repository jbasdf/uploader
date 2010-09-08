class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  
  def current_user
    User.first
  end
end
