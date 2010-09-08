class DefaultController < ApplicationController
  
  before_filter :make_user
  
  def index
    
  end
  
  def uploadify
    
  end
  
  protected
    def make_user
      @user = User.first || User.create
    end
    
end