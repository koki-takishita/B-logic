class UserSessionsController < ApplicationController
  #layout 'start'

  skip_before_action :require_login, only: [:new, :create]
  skip_before_action :read_status_run_records

  def new
  end

  def create
    @user = login(user_params[:email], user_params[:password])
    respond_to do |format|
      if @user
        flash[:success] = t('.success')
        format.html { redirect_back(fallback_location: back_url) }
        format.js
      else
        flash[:danger] = t('.danger')
        format.html { redirect_back(fallback_location: back_url) }
        format.js
      end
    end
  end

  def destroy
    logout
    flash.now[:success] = t('.success')
    render 'home/top' 
  end

  def user_params
    params.require(:session).permit(:email, :password)
  end
end
