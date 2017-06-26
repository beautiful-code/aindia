# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user, :verify_user_has_logged_in
  include SessionsHelper

  private

  # Confirms a logged-in user.
  def verify_user_has_logged_in
    return if logged_in?
    flash[:danger] = 'Please log in.'
    redirect_to root_url
  end
end
