class IssuesController < ApplicationController
  before_action :verify_user_has_logged_in, only: [:new, :create, :destroy]
  before_action :verify_current_user_is_owner,   only: :destroy

  def new
    @issue = Issue.new
  end

  def create
    @issue = current_user.issues.build(issue_params)
    if @issue.save
      flash[:success] = "Issue created!"
      redirect_to root_url
    else
      @feed_items = []
    end
  end

  private

    def issue_params
      params.require(:issue).permit(:content, :imageurl, :user_id, :title)
    end

    # verifying that the current user is the owner of the issue
    def verify_current_user_is_owner
      @issue = current_user.issues.find_by(id: params[:id])
      redirect_to root_url if @issue.nil?
    end

end
