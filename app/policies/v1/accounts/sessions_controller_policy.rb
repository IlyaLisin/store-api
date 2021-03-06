# frozen_string_literal: true

module V1
  module Accounts
    class SessionsControllerPolicy < ApplicationPolicy
      def create_session?
        !user.present?
      end

      def destroy?
        user.present? || raise(UnauthorizedError)
      end
    end
  end
end
