class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def index
    @goals = current_user.goals
  end

  def show
    @goal = current_user.goals.find(params[:id])
    session[:goal_id] = @goal.id.to_s
  end

  def create
    @goal = current_user.goals.build(goal_params)
    @goal.when_deadline(@goal.selectbox_parameter.to_i) if @goal.selectbox_parameter.present?
    @goal.current_status
    if @goal.save
      flash[:success] = t 'goals.flash.create'
      redirect_to goals_path
    else
      flash[:success] = t 'goals.flash.destroy'
      render :new
    end
  end

  def edit
    @goal = current_user.goals.find(params[:id])
  end

  def update
    @goal = current_user.goals.find(params[:id])
    @goal.assign_attributes(goal_params)
    @goal.when_deadline(@goal.selectbox_parameter.to_i)
    if @goal.save
      flash[:success] = t 'goals.flash.update'
      redirect_to goal_path(@goal)
    else
      render :edit
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
      params.require(:goal).permit(:embodiment, :quantification, :unit, :what_to_do, :selectbox_parameter)
    end
end
