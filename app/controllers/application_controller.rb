class ApplicationController < ActionController::Base
  before_action :require_login

  def not_authenticated
    redirect_to login_path, alert: 'Please login first'
  end

  def when_deadline(month)
    if self.persisted?
      self.deadine_on = self.deadline_on.since(month.month)
    else
      deadline = Date.today >> month
      self.deadline_on = deadline.end_of_day
    end
  end
end
