# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  devise :authenticatable

  has_many :purchase_orders, dependent: :destroy

  before_validation :email_to_downcase
  validates :email, presence: true, uniqueness: true, email: true
  validates_uniqueness_of :reset_password_token, allow_nil: true
  validates_uniqueness_of :confirmation_token, allow_nil: true

  def confirmed?
    self.confirmed_at.present?
  end

  def confirm_email
    self.confirmed_at = Time.current
    self.confirmation_token = nil
    self.confirmation_sent_at = nil
  end

  def set_confirmation_token
    self.confirmed_at = nil
    self.confirmation_token = SecureRandom.urlsafe_base64.to_s
    self.confirmation_sent_at = Time.current
  end

  private

  def email_to_downcase
    self.email = email.downcase if email.present?
  end
end
