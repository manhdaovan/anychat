class RoomsController < ApplicationController
  include BeforeActionTrigger
  before_action :require_login, :store_next_url

  def index
    @q = User.ransack(params[:q])
    @selected_username = params.fetch(:username, nil)
  end
end
