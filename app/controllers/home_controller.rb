class HomeController < ApplicationController
  def index
    @user = User.new
  end

  def login
    @user = User.new(login_params)
    if type_new_user?
      user_register
    else
      user_login
    end
  end

  def logout
    logout_user
    redirect_to root_path
  end

  private

  def type_new_user?
    params.fetch(:user, {}).fetch(:is_new, 0).to_i == 1
  end

  def login_params
    if type_new_user?
      params.require(:user).permit(:username, :password, :password_confirmation, :is_new)
    else
      params.require(:user).permit(:username, :password, :is_new)
    end
  end

  def user_register
    if @user.valid?
      @user.save
      @user.create_qr_code
      store_user_info(@user)
      flash[:success] = 'Your account has been created! Welcome to your anychat!'
      redirect_back_or rooms_path
    else
      render :index
    end
  end

  def user_login
    user = User.find_by(username: login_params.fetch(:username, ''))
    if user && user.authenticate(login_params.fetch(:password, nil))
      store_user_info(user)
      flash[:success] = 'Welcome to your anychat!'
      redirect_back_or rooms_path
    else
      @user.errors.add(:username_or_password,
                       'is invalid. Choose new user option if you want to create new account.')
      render :index
    end
  end
end
