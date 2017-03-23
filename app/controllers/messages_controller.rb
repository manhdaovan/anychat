class MessagesController < ApplicationController
  include BeforeActionTrigger
  before_action :require_login, :store_next_url

  def index
    @online = online?(params.fetch(:username, ''))
  end

  def create
  end
end
