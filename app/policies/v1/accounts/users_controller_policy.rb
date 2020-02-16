# frozen_string_literal: true

module V1
  module Accounts
    class UsersControllerPolicy < AuthorizedUserPolicy
      def show?
        true
      end
    end
  end
end
