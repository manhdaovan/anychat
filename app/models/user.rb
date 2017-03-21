# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(100)      not null
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  USERNAME_REGEX = /[a-zA-Z0-9]/
  has_secure_password

  validates :username, presence: true, length: {minimum: 6, maximum: 50}, format: USERNAME_REGEX
  validates :password, presence: true, length: {minimum: 8, maximum: 50}
end
