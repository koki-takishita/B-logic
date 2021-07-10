module ApplicationHelper
  def order_join(*names)
    object = names.map{|name| name.to_s}
    return object.join
  end

  def days_left(day)
    today = Date.today
    sa = day.to_date - today
    int = sa.to_i
    int.to_s
  end

  def selected_goal
    @selected_goal ||= current_user.goals.find_by_id(session[:goal_id]) if session[:goal_id]
  end

  def selected_subgoal
    @selected_subgoal ||= selected_goal.subgoals.find_by_id(session[:subgoal_id]) if session[:subgoal_id]
  end

  def subgoal_deadline(object)
    select = {'１ヶ月後'=> 1, '２ヶ月後'=> 2, '３ヶ月後'=> 3, '４ヶ月後'=> 4, '５ヶ月後'=> 5, '半年後'=> 6, 'これ以上期限を延ばす場合は目標の期限を延ばしてください' => 0 }
    # goalをもとに何ヶ月伸ばせるかがわかる
    deadline = @subgoal.delivery_time_to_month(object)
    select_form = select.select{|key, value| deadline.to_i >= value.to_i}
  end
end
