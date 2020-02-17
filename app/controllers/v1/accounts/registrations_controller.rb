# frozen_string_literal: true

module V1
  module Accounts
    class RegistrationsController < ApplicationController
      def create
        V1::Accounts::RegisterQuery.call(nil, request)

        render status: :no_content
      end

      def confirm_email
        V1::Accounts::ConfirmEmailQuery.call(nil, request)

        render status: :no_content
      end
    end
  end
end
