module GoalsHelper
  def goals_select 
    current_user.goals.map{|goal| [goal.name, goal.id]}.to_h
  end
end
