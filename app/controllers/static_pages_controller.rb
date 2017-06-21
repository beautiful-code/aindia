# frozen_string_literal: true

class StaticPagesController < ApplicationController
  include SupportIssue

  def home
    @feed_items = @current_user.issues_based_on_my_interests if logged_in?
  end

  def help; end

  def contact; end
end
