class UsersController < ApplicationController
  include BeforeActionTrigger
  before_action :require_login, :store_next_url

  def index
    @q = User.ransack(params[:q])
    @people = @q.result(distinct: true)
  end

  def edit

  end

  def update

  end
end
