module ApplicationHelper
  def order_join(*names)
    object = names.map{|name| name.to_s}
    return object.join
  end

  def selected_goal
    @selected_goal ||= current_user.goals.find_by_id(session[:goal_id]) if session[:goal_id]
  end

  def selected_subgoal
    @selected_subgoal ||= selected_goal.subgoals.find_by_id(session[:subgoal_id]) if session[:subgoal_id]
  end

  def selected_task
    @selected_task ||= selected_subgoals.find_by_id(session[:task_id]) if session[:task_id]
  end

  def active_if(action: nil, id: nil)
    return active_instance(id) if id && model_instance
    active_action(action) if action
  end

  def model_instance
    @issue || @goal
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
end
