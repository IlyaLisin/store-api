module V1
  module Accounts
    class RegisterUser
      include Interactor::Organizer

      organize CreateUser, SendConfirmationEmail
    end
  end
end
