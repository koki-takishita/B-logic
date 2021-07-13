class UserSessionsController < ApplicationController
  layout 'start'

  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    @user = login(user_params[:email], user_params[:password])
    if @user
      redirect_to(:root, notice: 'Login successful')
    else
      redirect_to request.referer
    end
  end

  def destroy
    logout
    redirect_to(:login, notice: 'Logged out!')
  end

  def user_params
    params.require(:user_session).permit(:email, :password)
  end
end
