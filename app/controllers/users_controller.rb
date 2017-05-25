class UsersController < ApplicationController
  include UsersHelper

  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
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
    flash[:success] = "User deleted"
    redirect_to users_url
  end

private
def user_params
  params.require(:user).permit(:name, :uid, :provider, :oauth_token, :oauth_expires_at, :email, :image_url, :dob, :gender)
end


end
