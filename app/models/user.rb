# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(100)      not null
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  last_logged_in  :datetime
#  email           :string(255)      default("")
#

class User < ApplicationRecord
  USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/i
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  has_secure_password

  validates :username, presence: true,
            length: {minimum: 6, maximum: 50},
            format: {with: USERNAME_REGEX}, on: :create
  validates :password, presence: true,
            length: {minimum: 8, maximum: 50}, on: :create
  validates :email, format: {with: EMAIL_REGEX},
            length: {maximum: 255}, allow_blank: true
end
