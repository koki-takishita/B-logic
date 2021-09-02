class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :read_status_run_records

  def not_authenticated
    redirect_to root_path, alert: 'ログインしてください'
  end

  def read_status_run_records
    if logged_in?
      goal, task = read_expired_models(models_hash)
      @expired_models = push_records(goal, task)
    end
  end

  def issue_empty
    if current_user.goals.blank?
      flash[:danger] ='目標を作成してください'
      redirect_to root_path
    end
  end

  def task_empty
    if current_user.issues.blank?
      flash[:danger] ='課題を作成してください'
      redirect_to root_path
    end
  end

  private

    def read_expired_models(models)
      models.map{|model|
        instances = model.where(user_id: current_user.id).where.not(status: 1)
        model_time_check(instances)
      }
    end

    # 時間を比較して、今の時間より遅かったらexpired!
    def model_time_check(instances)
      instances.map{|instance|
        case instance
        when Goal then
          instance if instance.expired! if instance.deadline <= Time.zone.now
        when Task then
          instance if instance.expired! if time_conmparison(instance)
        end
      }
    end

    def time_conmparison(instance)
      target = convert_date_to_time(instance.reminder.hour, instance.reminder.min)
      target < current_time
    end

    def convert_date_to_time(hour, min)
      Tod::TimeOfDay.new hour, min
    end

    def current_time
      hour = Time.zone.now.hour
      min = Time.zone.now.min
      convert_date_to_time(hour, min)
    end

    def models_hash
      ["Goal", "Task"].map{|model| model.constantize}
    end

    def push_records(model1, model2)
      records = []
      model1.each{|model|
        records << model unless model == nil
      }
      model2.each{|model|
        records << model unless model == nil
      }
      records
    end
end
