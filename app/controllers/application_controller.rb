class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :read_status_run_records

  def not_authenticated
    redirect_to root_path, alert: 'Please login first'
  end

  def read_status_run_records
    if logged_in?
      goal, task = read_expired_models(models_hash)
      @expired_models = push_records(goal, task)
    end
  end

  def issue_empty
    if current_user.goals.blank?
      redirect_to root_path
    end
  end

  def task_empty
    if current_user.issues.blank?
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
      records << model1 unless model1 == nil
      records << model2 unless model2 == nil
    end
end
