# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  name                   :string
#  phone                  :string
#  email                  :string           not null
#  password_digest        :string           not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  confirmation_token     :string
#  confirmation_sent_at   :datetime
#  confirmed_at           :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  has_secure_password

  devise :authenticatable

  has_many :purchase_orders, dependent: :destroy

  before_validation :email_to_downcase
  validates :email, presence: true, uniqueness: true, email: true
  validates_uniqueness_of :reset_password_token, allow_nil: true
  validates_uniqueness_of :confirmation_token, allow_nil: true

  def confirmed?
    confirmed_at.present?
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
