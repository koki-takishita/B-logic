class TasksController < ApplicationController
  before_action :task_empty, only: [:index]

  def index
    @tasks = current_user.tasks.order(:reminder).includes(:issue)
  end

  def create
    issue = issue_find
    @task = issue.tasks.build(task_params)
    respond_to do |format|
      if @task.save
        flash[:success] = "タスクを作成しました"
        format.html { redirect_back(fallback_location: back_url) }
        format.js
      else
        flash[:danger] = "タスクを作成できませんでした"
        format.html { redirect_back(fallback_location: back_url) }
        format.js
      end
    end
  end

  def update
    @task = task_find
    @task.assign_attributes(task_params)
    @task.status = 'run'
    respond_to do |format|
      if @task.save
        flash[:success] = "タスクを更新しました"
        format.html { redirect_back(fallback_location: back_url) }
        format.js
      else
        flash[:danger] = "タスクを更新できませんでした"
        format.html { redirect_back(fallback_location: back_url) }
        format.js
      end
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id]) 
    if @task.destroy
      flash[:success] = "タスクを削除しました"
    end
  end

  def status_run
    @task = current_user.tasks.find(params[:id]) 
    @task.run!
    time_check(@task)
  end

  def status_done
    @task = current_user.tasks.find(params[:id]) 
    @task.done!
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

    def add_queue(task)
      on_time = ontime(task)
      AsyncLogJob.set(wait_until: on_time).perform_later(task)
    end

    def ontime(object)
      year = Time.zone.now.year
      month = Time.zone.now.month
      day = Time.zone.now.day
      hour = object.reminder.hour
      min = (object.reminder + 1.minute).min
      Time.zone.local(year, month, day, hour, min)
    end

    def time_check(task)
      task.expired! unless task.reminder > Time.zone.now
    end
end
