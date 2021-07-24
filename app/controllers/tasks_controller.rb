class TasksController < ApplicationController

  def index
    @tasks = current_user.tasks
  end

  def create
    issue = issue_find
    @task = issue.tasks.build(task_params)
    if @task.save
      redirect_back(fallback_location: back_url)
    else
      render 'home/top'
    end
  end

  def update
    @task = task_find
    @task.assign_attributes(task_params)
    if @task.save
      flash[:success] = t 'task.flash.update'
      redirect_back(fallback_location: back_url)
    else
      render :edit
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id]) 
    if @task.destroy
      redirect_back(fallback_location: back_url)
    end
  end

  private

    def task_params
      params.require(:task).permit(:name, :reminder, :user_id)
    end

    def params_int(model_params)
      model_params.each do |key, value|
        if integer_string?(value)
          model_params[key] = value.to_i
        end
      end
    end

    def back_url
      url = Rails.application.routes.recognize_path(request.referrer)
      previous_action = url[:action]
    end

    def integer_string?(str)
      Integer(str)
        true
      rescue ArgumentError
        false
    end

    def issue_find
      Issue.find(params[:task][:issue_id])
    end

    def task_find
      issue = issue_find
      issue.tasks.find(params[:id])
    end
end
