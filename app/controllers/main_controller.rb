class MainController < ApplicationController
  def index
    redirect_to(login_path(params[:domain])) if params[:domain]
  end
  
  def login
    authenticate_with_open_id("https://www.google.com/accounts/o8/site-xrds?hd=" + params[:domain],{ :required   => ["http://axschema.org/contact/email", :email]}) do |result, identity_url, registration|
      if result.successful?
        # Succesfully logged in
  	    # email = get_email(registration)
  	    redirect_to(posts_path)
      else
  	    # Failed to login
  	    raise 'nope'
      end
    end
  end
end
