# frozen_string_literal: true

class IssuesController < ApplicationController
  before_action :verify_current_user_is_owner, only: %i[destroy edit update]

  def new
    @issue = Issue.new
  end

  def create
    @issue = current_user.issues.build(issue_params)
    @issue.attributes = {
      'social_interest_ids' => []
    }.merge(params[:issue] || {})

    if @issue.save
      flash[:success] = 'Issue created!'
      redirect_to user_path(@issue.user)
    else
      render 'new'
    end
  end

  def destroy
    return unless @issue.destroy
    flash[:success] = 'Issue deleted'
    redirect_to @current_user
  end

  def edit;  end

  def update
    update_attributes
  end

  private

  def issue_params
    params.require(:issue).permit(
      %i[content imageurl title impact cost socialinterest_ids]
    )
  end

  def update_attributes
    @issue.attributes = {
      'social_interest_ids' => []
    }.merge(params[:issue] || {})

    if @issue.save
      flash[:success] = 'Issue saved!'
      redirect_to user_path(@issue.user)
    else
      render 'edit'
    end
  end

  # verifying that the current user is the owner of the issue
  def verify_current_user_is_owner
    @issue = current_user.issues.find(params[:id])
    redirect_to root_url if @issue.nil?
  end
end
