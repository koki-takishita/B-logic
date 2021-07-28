class GoalsController < ApplicationController

  def index
    @goals = current_user.goals
  end

  def create
    @goal = current_user.goals.build(goal_params)
    respond_to do |format|
      if @goal.save
        flash[:success] = "目標を作成しました" 
        format.html { redirect_back(fallback_location: back_url) }
        format.js
      else
        flash[:danger] = "目標を作成できませんでした"
        format.html { redirect_back(fallback_location: back_url) }
        format.js
      end
    end
  end

  def update
    @goal = current_user.goals.find(params[:id])
    @goal.assign_attributes(goal_params)
    @goal.status = 'run'
    respond_to do |format|
      if @goal.save
        flash[:success] = "目標を更新しました" 
        format.html { redirect_back(fallback_location: back_url) }
        format.js
      else
        flash[:danger] = "目標を更新できませんでした"
        format.html { redirect_back(fallback_location: back_url) }
        format.js
      end
    end
  end

  def destroy
    @goal = current_user.goals.find(params[:id])
    if @goal.destroy
      flash[:success] = '目標を削除しました'
    end
  end

  def status_run
    @goal = current_user.goals.find(params[:id])
    @goal.run!
    time_check(@goal)
  end

  def status_done
    @goal = current_user.goals.find(params[:id])
    @goal.done!
  end

  private

    def goal_params
      params.require(:goal).permit(:name, :deadline)
    end

    def back_url
      url = Rails.application.routes.recognize_path(request.referrer)
      previous_action = url[:action]
    end

    def time_check(goal)
      goal.expired! unless goal.deadline > Time.zone.now
    end

end
