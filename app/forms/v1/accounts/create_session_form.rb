# frozen_string_literal: true

module V1
  module Accounts
    class CreateSessionForm < BaseForm
      TYPE = 'session'

      ATTRIBUTES = %w[
        email
        password
      ].freeze

      attr_accessor(*ATTRIBUTES)

      validates_presence_of :email, :password
    end
  end
end
