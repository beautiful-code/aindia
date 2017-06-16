module SupportIssue
    extend ActiveSupport::Concern

    def update_support_issue
      byebug
      issue = Issue.all.find(params[:issue_id])
      @current_user.update_support_issue(issue)
      redirect_to :back
    end
end
