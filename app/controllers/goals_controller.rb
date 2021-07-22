class GoalsController < ApplicationController

  def index
    @goals = current_user.goals
  end

  def create
    @goal = current_user.goals.build(goal_params)
    if @goal.save
      flash[:success] = t 'goals.flash.create'
      redirect_to goals_path 
    else
      flash[:success] = t 'goals.flash.danger'
      render 'home/top' 
    end
  end

  def update
    @goal = current_user.goals.find(params[:id])
    @goal.assign_attributes(goal_params)
    if @goal.save
      flash[:success] = t 'goals.flash.update'
      redirect_to goals_path
    else
      render :index
    end
  end

  def destroy
    @goal = current_user.goals.find(params[:id])
    if @goal.destroy
      flash[:danger] = t 'goals.flash.destroy'
      redirect_to goals_path
    end
  end

  private

    def goal_params
      params.require(:goal).permit(:name, :deadline)
    end

end
