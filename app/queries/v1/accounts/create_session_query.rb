# frozen_string_literal: true

module V1
  module Accounts
    class CreateSessionQuery < ApplicationQuery
      def call
        form = CreateSessionForm.new(params)
        form.validate!

        Accounts::CreateSession.call!(form: form).user
      end
    end
  end
end
