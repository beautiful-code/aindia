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
end
