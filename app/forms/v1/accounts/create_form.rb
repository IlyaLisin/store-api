# frozen_string_literal: true

module V1
  module Accounts
    class CreateForm < BaseForm
      TYPE = 'user'

      ATTRIBUTES = %w[
        name
        email
        phone
        password
      ].freeze

      attr_accessor(*ATTRIBUTES)

      validates_presence_of :name, :email, :password
      validate :validate_phone, unless: -> { phone.blank? }

      private

      def validate_phone
        errors.add(:phone, 'phone number is invalid') unless
            Phonelib.parse(phone).valid?
      end
    end
  end
end
