# frozen_string_literal: true

module V1
  module Accounts
    class CreateSessionForm < JSONAPIForm::Base
      TYPE = 'session'

      ATTRIBUTES = %w[
        email
        password
      ].freeze

      validates_presence_of :email, :password
    end
  end
end
