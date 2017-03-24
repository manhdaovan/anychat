class UsersController < ApplicationController
  include BeforeActionTrigger
  before_action :require_login, :store_next_url

  def index
    return unless request.post?
    @q = User.search(params[:q])
    @users = @q.result.page(params.fetch(:page, 1)).per(15)
  end

  def edit
  end

  def update
  end

  def check_online
    username = params.fetch(:username, '')
    render json: {online: online?(username)}
  end
end
