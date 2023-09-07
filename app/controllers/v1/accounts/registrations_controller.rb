# frozen_string_literal: true

module V1
  module Accounts
    class RegistrationsController < ApplicationController
      # POST /v1/accounts/sign_up
      def create
        Accounts::RegisterUser.call!(params: params.permit!.to_h)

        render status: :no_content
      end

      # PATCH /v1/accounts/email_confirmation
      def confirm_email
        Accounts::ConfirmEmail.call!(confirmation_token: params[:confirmation_token])

        render status: :no_content
      end
    end
  end
end
