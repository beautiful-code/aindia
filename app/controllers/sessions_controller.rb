class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    log_in(user)
    
    #session[:user_id] = user.id
    #redirect_to root_path
    redirect_to user
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end

# auth = request.env['omniauth.auth']
# unless @auth = Authorization.find_from_hash(auth)
#   # Create a new user or add an auth to existing user, depending on
#   # whether there is already a user signed in.
#   @auth = Authorization.create_from_hash(auth, current_user)
# end
# # Log the authorizing user in.
# self.current_user = @auth.user
