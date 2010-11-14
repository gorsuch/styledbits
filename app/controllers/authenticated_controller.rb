class AuthenticatedController < ApplicationController
  before_filter :get_user
  
  protected
  def get_user
    begin
      @user = User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to(root_path)
    end
  end
end
