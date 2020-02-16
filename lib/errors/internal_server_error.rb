# frozen_string_literal: true

# Класс для вызова ошибки InternalServerError
# @param msg [String] сообщение, которое будет отдаваться
# @param http [Integer] http-код ошибки
class InternalServerError < BaseError
  def initialize(msg = '', http = 500)
    super
  end
end
