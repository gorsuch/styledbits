class MainController < ApplicationController
  def index
    redirect_to(posts_path) if session[:user_id]
    redirect_to(login_path(params[:domain])) if params[:domain]
  end
  
  def login
    authenticate_with_open_id("https://www.google.com/accounts/o8/site-xrds?hd=" + params[:domain],{ :required   => ["http://axschema.org/contact/email", :email]}) do |result, identity_url, registration|
      if result.successful?
        # Succesfully logged in
  	    email = get_email(registration)
  	    account = Account.find_or_create_by_domain(params[:domain])
  	    user = account.users.find_or_create_by_email(email)
  	    session[:user_id] = user.id
  	    redirect_to(posts_path)
      else
  	    # Failed to login
  	    raise 'could not log you in'
      end
    end
  end
  
  private 
  
  def get_email(registration)
    ax_response = OpenID::AX::FetchResponse.from_success_response(request.env[Rack::OpenID::RESPONSE])
    ax_response.data["http://axschema.org/contact/email"].first
  end
  
end
