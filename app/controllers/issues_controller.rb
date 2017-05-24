class IssuesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy


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
      params.require(:issue).permit(:content, :picture)
    end

    def correct_user
      @issue = current_user.issues.find_by(id: params[:id])
      redirect_to root_url if @issue.nil?
    end

end
