# frozen_string_literal: true

module V1
  module Accounts
    class ConfirmEmailQuery < ApplicationQuery
      def call
        Accounts::ConfirmEmail.call!(confirmation_token: params[:confirmation_token])
      end
    end
  end
end
