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
    @goal.when_deadline(@goal.selectbox_parameter.to_i)
    @goal.current_status
    if @goal.save
      redirect_to goals_path, notice: '目標を作成しました.'
    else
      flash.now[:alert] = '目標を作成できませんでした.'
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
      redirect_to goal_path(@goal), notice: '目標を更新しました'
    else
      render :edit
    end
  end

  private

    def goal_params
      params.require(:goal).permit(:embodiment, :quantification, :unit, :what_to_do, :selectbox_parameter)
    end
end
