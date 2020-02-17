# frozen_string_literal: true

module V1
  module Accounts
    class RegistrationsControllerPolicy < ApplicationPolicy
      def create?
        !user.present?
      end

      def confirm_email?
        !user.present?
      end
    end
  end
end
