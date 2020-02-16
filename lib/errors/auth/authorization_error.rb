# frozen_string_literal: true

module Auth
  # Класс для вызова ошибки auth_authorization_error
  # @param msg [String] сообщение, которое будет отдаваться
  # @param http [Integer] http-код ошибки
  class AuthorizationError < BaseError
    def initialize(msg = '', http = 400)
      super(msg, http)
    end
  end
end
