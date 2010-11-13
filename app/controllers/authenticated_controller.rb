class AuthenticatedController < ApplicationController
  before_filter :get_user
  
  protected
  def get_user
    user = User.find(session[:user_id])
  end
end
