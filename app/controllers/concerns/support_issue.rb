# frozen_string_literal: true

module SupportIssue
  extend ActiveSupport::Concern

  def update_support_issue
    issue = Issue.find(params[:issue_id])
    @current_user.update_support_issue(issue)
    redirect_to :back
  end
end
