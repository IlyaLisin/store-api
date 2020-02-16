# frozen_string_literal: true

# Класс для вызова ошибки bad_request
# @param msg [String] сообщение, которое будет отдаваться
# @param http [Integer] http-код ошибки
class BadRequestError < BaseError
  def initialize(msg = '', http = 400)
    super
  end
end
