class IssuesController < ApplicationController
  before_action :verify_user_has_logged_in, only: [:new, :create, :destroy]
  before_action :verify_current_user_is_owner,   only: [:destroy, :edit]

  def new
    @issue = Issue.new
  end

  def save_attributes
    @issue.attributes = {'socialinterest_ids' => []}.merge(params[:issue] || {})

    if @issue.save
      flash[:success] = "Issue saved!"
      redirect_to user_path(@issue.user)
    else
      # flash[:success] = "Issue creation failed!"
      # redirect_to user_path
    end
  end

  def create
    @issue = current_user.issues.build(issue_params)
    @issue.attributes = {'socialinterest_ids' => []}.merge(params[:issue] || {})

    if @issue.save
      flash[:success] = "Issue created!"
      redirect_to root_url
    else
      # flash[:success] = "Issue creation failed!"
      # redirect_to user_path
    end
  end

  def destroy
    @issue.destroy
    flash[:success] = "Issue deleted"
    redirect_to @current_user
  end

  def edit
    @issue = Issue.find(params[:id])

  end

  def update
    @issue = Issue.find(params[:id])
    save_attributes
  end

  private

    def issue_params
      params.require(:issue).permit(:content, :imageurl, :user_id, :title, :impact, :cost, :socialinterest_ids)
    end

    # verifying that the current user is the owner of the issue
    def verify_current_user_is_owner
      @issue = current_user.issues.find_by(id: params[:id])
      redirect_to root_url if @issue.nil?
    end

end
