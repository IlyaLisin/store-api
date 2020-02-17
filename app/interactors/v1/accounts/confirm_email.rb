# frozen_string_literal: true

module V1
  module Accounts
    class ConfirmEmail
      include Interactor

      delegate :confirmation_token, to: :context

      def call
        user = User.find_by!(confirmation_token: confirmation_token)

        user.confirm_email

        user.save!
      end
    end
  end
end
