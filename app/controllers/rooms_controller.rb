class RoomsController < ApplicationController
  include LoginRequired

  def index
    @q = User.ransack(params[:q])
    @people = @q.result(distinct: true)
  end
end
