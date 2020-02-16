module V1
  module Accounts
    class RegistrationsController < ApplicationController
      def create
        V1::Accounts::RegisterQuery.call(nil, request)

        render status: :created
      end

      def confirm_email
        V1::Accounts::ConfirmEmailQuery.call(nil, request)

        render status: :ok
      end
    end
  end
end

