class HomeController < ApplicationController
  skip_before_action :require_login, only: [:top]

  def top
  end

  def play_policies
  end

  def terms_of_service
  end

end
