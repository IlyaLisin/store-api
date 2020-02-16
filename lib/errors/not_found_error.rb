# frozen_string_literal: true

# Класс для вызова ошибки not found
# @param msg [String] сообщение, которое будет отдаваться
# @param http [Integer] http-код ошибки
class NotFoundError < BaseError
  def initialize(msg = 'not found', http = 404, **options)
    super(msg, http, **options)
  end
end
