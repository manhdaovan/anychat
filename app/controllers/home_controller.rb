class HomeController < ApplicationController
  def index
    @user = User.new
  end

  def login
    @user = User.new(login_params)
    if @user.valid?
      user = User.find_by(username: @user.username)
      if user.nil? && @user.save
        store_user_info(@user)
        flash[:success] = 'Your account has been created! Welcome to your anychat!'
        redirect_back_or rooms_path
      else
        if user.authenticate(login_params.fetch(:password, nil))
          store_user_info(user)
          flash[:success] = 'Welcome to your anychat!'
          redirect_back_or rooms_path
        else
          @user.errors.add(:password, 'invalid')
          render :index
        end
      end
    else
      render :index
    end
  end

  private

  def login_params
    params.require(:user).permit(:username, :password)
  end
end
