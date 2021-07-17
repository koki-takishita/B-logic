class TasksController < ApplicationController
  def new
    @task = view_context.selected_subgoal.tasks.build 
  end

  def show
    @task = view_context.selected_subgoal.tasks.find_by_id(params[:id]) 
    session[:task_id] = @subgoal.id.to_s
  end

  def create
    @task = view_context.selected_subgoal.tasks.build(task_params)
    @task.task_type_check
=begin
    if @task.save
      flash[:success] = t 'task.flash.create'
      redirect_to task_path(@task)
    else
      flash[:success] = t 'task.flash.danger'
      render :new
    end
=end
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
      params_int(params.require(:task).permit(:task_type, :task, :deadline_on, :time_limit))
    end

    def params_int(model_params)
      model_params.each do |key, value|
        if integer_string?(value)
          model_params[key] = value.to_i
        end
      end
    end

    def integer_string?(str)
      Integer(str)
        true
      rescue ArgumentError
        false
    end
end
