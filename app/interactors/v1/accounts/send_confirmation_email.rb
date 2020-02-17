# frozen_string_literal: true

module V1
  module Accounts
    class SendConfirmationEmail
      include Interactor

      delegate :user, to: :context

      def call
        UserMailer.registration_confirmation(user).deliver_later
      rescue => e
        Rails.logger.error "Error in Users::SendConfirmationEmail interactor: #{e.message}"
        Rails.logger.error e.backtrace
        context.fail!(errors: 'Error while sending email')
      end
    end
  end
end
