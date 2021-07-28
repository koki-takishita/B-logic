module IssuesHelper
  def issues_select 
    current_user.issues.map{|issue| [issue.solution, issue.id]}.to_h
  end
end
