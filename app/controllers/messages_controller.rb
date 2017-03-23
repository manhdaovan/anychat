class MessagesController < ApplicationController
  include BeforeActionTrigger
  before_action :require_login, :store_next_url

  def index
    @offline = Rails.cache.read(params.fetch(:username, '')).nil?
  end

  def create
  end
end
