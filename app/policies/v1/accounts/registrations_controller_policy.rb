# frozen_string_literal: true

module V1
  module Accounts
    class RegistrationsControllerPolicy < ApplicationPolicy
      def create?
        true
      end

      def confirm_email?
        true
      end
    end
  end
end
