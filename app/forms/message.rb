class Message
  include ActiveModel::Model
  attr_accessor :from_user, :to_user, :msg_content

  validates :from_user, :to_user, :msg_content, presence: true
  validates :from_user, :to_user, format: { with: User::USERNAME_REGEX }
  validates :msg_content, length: { maximum: 1000 }
end
