class IssuesController < ApplicationController
  before_action :verify_user_has_logged_in, only: [:new, :create, :destroy]
  before_action :verify_current_user_is_owner,   only: :destroy

  def new
    @issue = Issue.new
  end

  def create
    byebug
    @issue = current_user.issues.build(issue_params)
    # To save the interest attributes
    @issue.attributes = {'socialinterest_ids' => []}.merge(params[:issue] || {})

    if @issue.save
      flash[:success] = "Issue created!"
      redirect_to root_url
    else
      @feed_items = []
    end
  end

  def destroy
    # user = User.find(params[:id])
    @issue.destroy
    flash[:success] = "Issue deleted"
    redirect_to @current_user
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
