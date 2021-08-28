module ApplicationHelper

  def active_if(action: nil, id: nil)
    return active_instance(id) if id && model_instance
    active_action(action) if action
  end

  def model_instance
    @goal || issue_instance || task_instance
  end

  def issue_instance
    return @issue.goal if action_name == 'create' && controller_name == 'issues'
    @issue
  end

  def task_instance
    @task.issue if @task || nil
  end

  def active_instance(id)
    id == model_instance.id ? css : ''
  end

  def active_action(action)
    css if action == action_name
  end

  def css
    case controller_name
    when 'issues' then
      'issue_active'
    when 'tasks' then
      'task_active'
    end
  end

  def format(object)
    return :time if object.model_name.name == 'Task'
    :date
  end
end
