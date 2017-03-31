class RoomsController < ApplicationController
  include BeforeActionTrigger
  before_action :store_next_url, :require_login

  def index
    @q = User.ransack(params[:q])
    @selected_username = params.fetch(:username, nil)
  end
end
