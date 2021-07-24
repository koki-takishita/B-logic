class GoalsController < ApplicationController

  def index
    @goals = current_user.goals
  end

  def create
    @goal = current_user.goals.build(goal_params)
    if @goal.save
      flash[:success] = t 'goals.flash.create'
      redirect_back(fallback_location: back_url)
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
      redirect_back(fallback_location: back_url)
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

    def back_url
      url = Rails.application.routes.recognize_path(request.referrer)
      previous_action = url[:action]
    end

end
