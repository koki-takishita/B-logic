class IssuesController < ApplicationController

  def index
    @issues = current_user.issues
  end

  def create
    goal = goal_find
    @issue = goal.issues.build(issue_params)
    if @issue.save
      flash[:success] = t 'issues.flash.create'
      redirect_back(fallback_location: back_url)
    else
      flash[:success] = t 'issues.flash.danger'
      render 'home/top' 
    end
  end

  def update
    goal = goal_find
    @issue = goal.issues.find_by_id(params[:id])
    @issue.assign_attributes(issue_params)
    if @issue.save
      flash[:success] = t 'issues.flash.update'
      redirect_back(fallback_location: back_url)
    else
      render :index
    end
  end

  def destroy
    @issue = current_user.issues.find(params[:id])
    if @issue.destroy
      flash[:danger] = t 'issues.flash.destroy'
      redirect_to issues_path
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
    end
end
