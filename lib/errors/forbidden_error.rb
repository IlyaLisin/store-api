# frozen_string_literal: true

# Класс для вызова ошибки forbidden
# @param msg [String] сообщение, которое будет отдаваться
# @param http [Integer] http-код ошибки
class ForbiddenError < BaseError
  def initialize(msg = 'forbidden', http = 403)
    super
  end
end
