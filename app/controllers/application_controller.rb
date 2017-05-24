class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  protected
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?
  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

private
  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to root_url
    end
  end

end
