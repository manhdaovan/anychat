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
  EMAIL_REGEX    = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  has_secure_password

  validates :username, presence: true,
            length:              {minimum: 6, maximum: 50},
            format:              {with: USERNAME_REGEX}, on: :create
  validates :password, presence: true,
            length:              {minimum: 8, maximum: 50}, on: :create
  validates :email, format: {with: EMAIL_REGEX},
            length:         {maximum: 255}, allow_blank: true

  def create_qr_code
    require 'rqrcode'
    Dir.mkdir("#{Rails.root}/public/system/#{id}")
    qrcode = RQRCode::QRCode.new(profile_url)
    image  = qrcode.as_png(
      resize_gte_to:     false,
      resize_exactly_to: false,
      fill:              'white',
      color:             'black',
      size:              120,
      border_modules:    4,
      module_px_size:    6,
      file:              "#{Rails.root}/public/system/#{id}/#{username}.png"
    )
  end

  def qr_code_url
    file_path = "#{Rails.root}/public/system/#{id}/#{username}.png"
    return nil unless File.exist?(file_path)
    "#{Rails.application.routes.url_helpers.root_url}system/#{id}/#{username}.png"
  end

  def profile_url
    "#{Rails.application.routes.url_helpers.rooms_url}/#{username}"
  end
end
