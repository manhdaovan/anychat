class RoomsController < ApplicationController
  include BeforeActionTrigger
  before_action :require_login

  def index
    @q = User.ransack(params[:q])
    @people = @q.result(distinct: true)
  end
end
