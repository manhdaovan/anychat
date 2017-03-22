class MessagesController < ApplicationController
  def index
    @offline = Rails.cache.read(params.fetch(:username, '')).nil?
  end

  def create

  end
end
