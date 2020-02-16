module V1
  module Accounts
    class SendConfirmationEmail
      include Interactor

      delegate :user, to: :context

      def call
        UserMailer.registration_confirmation(user).deliver_later
      rescue => ex
        Rails.logger.error "Error in Users::SendConfirmationEmail interactor: #{ex.message}"
        Rails.logger.error ex.backtrace
        context.fail!(errors: 'Error while sending email')
      end
    end
  end
end
