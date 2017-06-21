# frozen_string_literal: true

class UsersController < ApplicationController
  include SupportIssue

  before_action :redirect_if_logged_in, only: %i[new create]
  before_action :verify_user_has_logged_in, only: [:show]
  before_action :set_user, only: [:show]

  def new
    redirect_to user if logged_in?
  end

  def show
    @issues = @user.issues.paginate(page: params[:page])
  end

  def edit; end

  def update
    if @current_user.update_attributes(user_params)
      # Handle a successful update.
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = 'User deleted'

    redirect_to users_url
  end

  def interests; end

  def update_follow_interests
    interest = SocialInterest.find(params[:interest_id])
    @current_user.update_follow_interests(interest)
    redirect_to :back
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      %i[
        name uid provider oauth_token oauth_expires_at email
        image_url dob gender
      ]
    )
  end

  def redirect_if_logged_in
    redirect_to @current_user if logged_in?
  end
end
