# frozen_string_literal: true

# Базовый класс ошибки
# @param msg [String] сообщение, которое будет отдаваться
# @param http [Integer] http-код ошибки
# @param pointer [Hash] source[:pointer] ошибки
class BaseError < StandardError
  attr_reader :http, :pointer, :meta

  def initialize(msg = '', http = 500, pointer: nil, meta: nil)
    @http = http
    @pointer = pointer
    @meta = meta
    super(msg)
  end

  def jsonapi_hash
    hash = {
      title: 'Error',
      detail: message
    }

    hash[:source] = { pointer: pointer } if pointer.present?
    hash[:meta] = meta if meta.present?

    hash
  end
end
