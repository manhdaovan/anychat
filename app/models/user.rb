# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  username            :string(100)      not null
#  password_digest     :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  last_logged_in      :datetime
#  email               :string(255)      default("")
#  active_email_digest :string(255)      default("")
#  receive_msg_offline :boolean          default(FALSE)
#

class User < ApplicationRecord
  USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/i
  EMAIL_REGEX    = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  has_secure_password

  attr_accessor :is_new
  attr_reader :username_or_password

  validates :username, presence: true,
                       length:              { minimum: 6, maximum: 50 },
                       format:              { with: USERNAME_REGEX },
                       uniqueness: true,
                       on: :create
  validates :password, presence: true,
                       length:              { minimum: 8, maximum: 50 }, on: :create
  validates :email, format: { with: EMAIL_REGEX },
                    length:         { maximum: 255 }, allow_blank: true

  def create_qr_code
    require 'rqrcode'
    dir = "#{Rails.root}/public/system/#{id}"
    Dir.mkdir(dir) unless File.directory?(dir)
    qrcode = RQRCode::QRCode.new(profile_url)
    qrcode.as_png(
      resize_gte_to:     false,
      resize_exactly_to: false,
      fill:              'white',
      color:             'black',
      size:              160,
      border_modules:    4,
      module_px_size:    6,
      file:              "#{Rails.root}/public/system/#{id}/#{username}.png"
    )
  end

  def qr_code_existing?
    File.exist?("#{Rails.root}/public/system/#{id}/#{username}.png")
  end

  def qr_code_url
    file_path = "#{Rails.root}/public/system/#{id}/#{username}.png"
    return nil unless File.exist?(file_path)
    "#{Rails.application.routes.url_helpers.root_url}system/#{id}/#{username}.png"
  end

  def profile_url
    "#{Rails.application.routes.url_helpers.rooms_url}/#{username}"
  end

  def new_token
    SecureRandom.urlsafe_base64
  end

  def gen_active_email_digest(token)
    self.active_email_digest = new_digest(token)
  end

  def valid_active_email_token?(token)
    return false if active_email_digest.blank?
    BCrypt::Password.new(active_email_digest).is_password?(token)
  end

  def clear_active_email_digest
    self.active_email_digest = ''
    save
  end

  def receive_offline_msg?
    receive_msg_offline && email.present? && active_email_digest.blank?
  end

  def type_register?
    is_new.to_i == 1
  end

  private

  def new_digest(token)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(token, cost: cost)
  end
end
