# frozen_string_literal: true

module V1
  module Accounts
    class SessionsController < ApplicationController
      def create_session
        user = Accounts::CreateSessionQuery.call(nil, request)

        sign_in user

        render json: UserSerializer.new(user)
      end

      def destroy
        sign_out
      end
    end
  end
end
