class HomeController < ApplicationController
  def index
  end

  def login

  end

  private

  def login_params
    params.require(:user).permit(:username, :password)
  end
end
