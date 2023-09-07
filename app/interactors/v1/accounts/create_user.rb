# frozen_string_literal: true

module V1
  module Accounts
    class CreateUser
      include Interactor

      delegate :params, :form, to: :context

      before do
        context.form = CreateForm.new(params)
        form.validate!
      end

      def call
        context.user = User.new(user_params)

        context.user.set_confirmation_token

        context.user.save!
      end

      private

      def user_params
        {
          name: form.name,
          phone: form.phone,
          email: form.email,
          password: form.password
        }
      end
    end
  end
end
