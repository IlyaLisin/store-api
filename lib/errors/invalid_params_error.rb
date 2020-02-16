# frozen_string_literal: true

# Класс для вызова ошибки invalid_params_error
# @param msg [String] сообщение, которое будет отдаваться
# @param http [Integer] http-код ошибки
class InvalidParamsError < BaseError
  def initialize(msg = '', http = 400)
    super
  end
end
