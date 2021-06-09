class UserSessionsController < ApplicationController
  layout 'start'

  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    @user = login(user_params[:email], user_params[:password])
    if @user
      redirect_to(:users, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:login, notice: 'Logged out!')
  end

  def user_params
=begin
    params.require(:user).permit(:email, :password)
=end
    params.permit(:email, :password)
  end
end
