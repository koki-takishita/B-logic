module TasksHelper
  def active_issue(id)
    id == @issue.id ? 'task_active' : ''
  end
end
