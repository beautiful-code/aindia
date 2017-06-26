# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    current_user
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    @current_user.present?
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end

  def log_out
    #  forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
