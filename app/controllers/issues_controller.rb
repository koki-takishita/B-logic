class IssuesController < ApplicationController
  before_action :issue_empty, only: [:index]

  def index
    @issues = current_user.issues
  end

  def create
    goal = goal_find
    @issue = goal.issues.build(issue_params)
    respond_to do |format|
      if @issue.save
        flash[:success] = '課題を作成しました' 

        format.html { redirect_back(fallback_location: back_url) }
        format.js
      else
        flash.now[:danger] = '課題を作成できませんでした'

        format.html { redirect_back(fallback_location: back_url) }
        format.js
      end
    end
  end

  def update
    goal = goal_find
    @issue = goal.issues.find_by_id(params[:id])
    @issue.assign_attributes(issue_params)
    respond_to do |format|
      if @issue.save
        flash[:success] = '課題を更新しました' 

        format.html { redirect_back(fallback_location: back_url) }
        format.js
      else
        flash.now[:danger] = '課題を更新できませんでした'

        format.html { redirect_back(fallback_location: back_url) }
        format.js
      end
    end
  end

  def destroy
    @issue = current_user.issues.find(params[:id])
    if @issue.destroy
      flash[:success] = '課題を削除しました'
    end
  end

  private

    def issue_params
      params.require(:issue).permit(:name, :solution, :user_id)
    end

    def goal_find
      goal = Goal.find(params[:issue][:goal_id])
    end

    def back_url
      url = Rails.application.routes.recognize_path(request.referrer)
      previous_action = url[:action]
      url[:controller] + "/" + url[:action]
    end

    def render_path
      url = Rails.application.routes.recognize_path(request.referrer)
      url[:controller] + "/" + url[:action]
    end

end
