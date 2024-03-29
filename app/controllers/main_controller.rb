class MainController < ApplicationController
  def index
    redirect_to(posts_path) if session[:user_id]
    if request.post?
      domain = params[:domain]
      domain.gsub!(/.*@/,'')
      redirect_to(login_path(domain)) 
    end
  end
  
  def login
    open_id_url = "https://www.google.com/accounts/o8/site-xrds?hd=" + params[:domain]
    authenticate_with_open_id(open_id_url,{ :required   => ["http://axschema.org/contact/email", :email]}) do |result, identity_url, registration|
      if result.successful?
        # Succesfully logged in
  	    email = get_email(registration)
  	    account = Account.find_or_create_by_domain(params[:domain])
  	    user = account.users.find_or_create_by_email(email)
  	    session[:user_id] = user.id
  	    redirect_to(posts_path)
      else
  	    # Failed to login
  	    flash[:notice] = "Could not log you in."
  	    render :index
      end
    end
  end
  
  def logout
    session.clear
    redirect_to(root_path)
  end
  
  private 
  
  def get_email(registration)
    ax_response = OpenID::AX::FetchResponse.from_success_response(request.env[Rack::OpenID::RESPONSE])
    ax_response.data["http://axschema.org/contact/email"].first
  end
  
end
