class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user
  include SessionsHelper

  private
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?
  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to root_url
    end
  end

end
