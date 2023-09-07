# frozen_string_literal: true

module V1
  module Accounts
    class SessionsController < ApplicationController
      # POST /v1/accounts/session
      def create_session
        user = Accounts::CreateSession.call!(params: params.permit!.to_h).user

        sign_in user

        render json: UserSerializer.new(user)
      end

      # DELETE /v1/accounts/session
      def destroy
        sign_out
      end
    end
  end
end
