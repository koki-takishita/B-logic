class HomeController < ApplicationController
  skip_before_action :require_login

  def top
  end

  def play_policies
  end

  def terms_of_service
  end

  def about
  end
end
