module V1
  module Accounts
    class CreateUser
      include Interactor

      delegate :form, to: :context

      def call
        context.user = User.new(name: form.name,
                                    phone: form.phone,
                                    email: form.email,
                                password: form.password)

        context.user.set_confirmation_token

        context.user.save!
      end
    end
  end
end

