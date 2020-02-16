# frozen_string_literal: true

module V1
  module Accounts
    class RegisterQuery < ApplicationQuery
      def call
        form = CreateForm.new(params)
        form.validate!

        Accounts::RegisterUser.call!(form: form)
      end
    end
  end
end
