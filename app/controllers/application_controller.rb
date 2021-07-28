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

  private

    def read_expired_models(models)
      models.map{|model| model.where(status: 2, user_id: current_user.id) }
    end

    def models_hash
      ["Goal", "Task"].map{|model| model.constantize}
    end

    def push_records(model1, model2)
      records = []
      records << model1
      records << model2
    end
end
