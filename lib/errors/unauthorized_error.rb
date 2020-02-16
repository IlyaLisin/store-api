# frozen_string_literal: true

# Класс для вызова ошибки unauthorized
# @param msg [String] сообщение, которое будет отдаваться
# @param http [Integer] http-код ошибки
class UnauthorizedError < BaseError
  def initialize(msg = 'unauthorized', http = 401, pointer: nil, meta: nil)
    super
  end
end
