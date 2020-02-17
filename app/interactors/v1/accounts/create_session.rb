# frozen_string_literal: true

module V1
  module Accounts
    class CreateSession
      include Interactor

      delegate :form, to: :context

      def call
        context.user = User.find_by_email(form.email)&.authenticate(form.password)

        raise AuthorizedError, 'Incorrect email or password' unless context.user
        raise AuthorizedError, 'Email is not confirmed' unless context.user.confirmed?
      end
    end
  end
end
