class StaticPagesController < ApplicationController
  include SupportIssue

  def home
    if logged_in?
      @feed_items = @current_user.get_issues_based_on_my_interests
    end
  end

  def help
  end

  def contact
  end

end
