class MessagesController < ApplicationController
  include BeforeActionTrigger
  before_action :require_login

  def index
    @offline = Rails.cache.read(params.fetch(:username, '')).nil?
  end

  def create

  end
end
