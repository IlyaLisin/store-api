# frozen_string_literal: true

module V1
  module Accounts
    class UsersController < ApplicationController
      def show
        render json: UserSerializer.new(current_user)
      end
    end
  end
end
