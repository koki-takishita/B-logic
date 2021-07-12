class SubgoalsController < ApplicationController
  def new
    @subgoal = view_context.selected_goal.subgoals.build 
  end

  def show
    @subgoal = view_context.selected_goal.subgoals.find_by_id(params[:id])
    session[:subgoal_id] = @subgoal.id
  end

  def create
    @subgoal = view_context.selected_goal.subgoals.build(subgoal_params)
    if @subgoal.save
      redirect_to goal_path(view_context.selected_goal)
      flash[:success] = 'サブ目標を作成しました.'
    else
      flash.now[:danger] = 'サブ目標を作成できませんでした.'
      render :new
    end
  end

  def edit
    @subgoal = view_context.selected_goal.subgoals.find_by_id(params[:id])
  end

  def update
    @subgoal = view_context.selected_goal.subgoals.find_by_id(params[:id])
    @subgoal.assign_attributes(subgoal_params)
    if @subgoal.save
      redirect_to subgoal_path(view_context.selected_subgoal), success: 'サブ目標を更新しました.'
    else
      flash.now[:danger] = 'サブ目標を更新できませんでした.'
      render :edit
    end
  end

  def destroy
    @subgoal = view_context.selected_goal.subgoals.find_by_id(params[:id])
    if @subgoal.destroy
      flash[:danger] = 'サブ目標を削除しました.'
      redirect_to goal_path(view_context.selected_goal)
    end
  end

  def subgoal_params
      params.require(:subgoal).permit(:embodiment, :quantification, :unit, :subgoal, :deadline_on)
  end
end
