class One2ManyChannel < ApplicationCable::Channel
  def subscribed
    puts "subscribed current_user", current_user.id
  end

  def unsubscribed
    puts "unsubscribed current_user", current_user.id
  end

  def appear(data)
    puts "appear current_user", current_user.id
  end

  def away
    puts "away current_user", current_user.id
  end
end
