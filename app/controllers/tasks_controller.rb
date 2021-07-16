class TasksController < ApplicationController
  def new
    @task = view_context.selected_subgoal.tasks.build 
  end

  def show
    @task = view_context.selected_subgoal.tasks.find_by_id(params[:id]) 
    session[:task_id] = @subgoal.id.to_s
  end

  def create
    @task = view_context.selected_subgoals.build(task_params)
    if @task.save
      flash[:success] = t 'task.flash.create'
      redirect_to task_path(@task)
    else
      flash[:success] = t 'task.flash.danger'
      render :new
    end
  end

  def edit
    @task = view_context.selected_subgoals.find(params[:id])
  end

  def update
    @task = view_context.selected_subgoals.find(params[:id])
    @task.assign_attributes(task_params)
    if @task.save
      flash[:success] = t 'task.flash.update'
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def destroy
    @task = view_context.selected_subgoals.find(params[:id])
    if @task.destroy
      flash[:danger] = t 'tasks.flash.destroy'
      redirect_to subgoals_path
    end
  end

  private

    def task_params
      params.require(:task).permit(:task_type, :task, :deadline_on)
    end

end
