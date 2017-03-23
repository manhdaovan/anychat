class UsersController < ApplicationController
  include BeforeActionTrigger
  before_action :require_login

  def edit

  end

  def update

  end
end
