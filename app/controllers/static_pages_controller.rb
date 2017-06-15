class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = Issue.all
    end
  end

  def help
  end

  def contact
  end

  def support_issue
    issue = Issue.all.find(params[:issue_id])
    @current_user.support_issue(issue)
    redirect_to :back
  end

end
