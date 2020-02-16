# frozen_string_literal: true

require 'devise/orm/active_record'

Devise.setup do |config|
  config.navigational_formats = []
  config.stretches = Rails.env.test? ? 1 : 11
  config.sign_out_via = :delete
end
