class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user
  include SessionsHelper

  private

  def signed_in?
    current_user
  end

  helper_method :current_user, :signed_in?
  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  # Confirms a logged-in user.
  def verify_user_has_logged_in
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to root_url
    end
  end
end
