# frozen_string_literal: true

module V1
  module Accounts
    class UsersController < ApplicationController
      # GET /v1/accounts
      def show
        render json: UserSerializer.new(current_user)
      end
    end
  end
end
