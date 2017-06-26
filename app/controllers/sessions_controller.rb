# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :verify_user_has_logged_in, except: [:destroy]
  skip_before_action :current_user, except: [:destroy]

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    log_in(user)
    redirect_to root_path
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
