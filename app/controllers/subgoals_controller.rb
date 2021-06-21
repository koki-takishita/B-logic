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
    @subgoal.when_deadline(@subgoal.selectbox_parameter.to_i)
    @subgoal.remainder(@subgoal.division_remainder, view_context.selected_goal)
    if @subgoal.save
      redirect_to goal_path(view_context.selected_goal), notice: 'サブ目標を作成しました.'
    else
      flash.now[:alert] = 'サブ目標を作成できませんでした.'
      render :new
    end
  end

  def edit
    @subgoal = view_context.selected_goal.subgoals.find_by_id(params[:id])
  end

  def update
    @subgoal = view_context.selected_goal.subgoals.find_by_id(params[:id])
    @subgoal.assign_attributes(subgoal_params)
    @subgoal.when_deadline(@subgoal.selectbox_parameter.to_i)
    if @subgoal.save
      redirect_to subgoal_path(view_context.selected_subgoal), notice: 'サブ目標を更新しました.'
    else
      flash.now[:alert] = 'サブ目標を更新できませんでした.'
      render :eidt
    end
  end

  def destroy
    @subgoal = view_context.selected_goal.subgoals.find_by_id(params[:id])
    if @subgoal.destroy
      redirect_to goal_path(view_context.selected_goal), notice: 'サブゴールを削除しました.'
    end
  end

  def subgoal_params
      params.require(:subgoal).permit(:embodiment, :quantification, :unit, :subgoal, :selectbox_parameter, :division_remainder)
  end
end
