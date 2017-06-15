module SupportIssue
    extend ActiveSupport::Concern

    def support_issue
      byebug
      issue = Issue.all.find(params[:issue_id])
      @current_user.support_issue(issue)
      redirect_to :back
    end
end
