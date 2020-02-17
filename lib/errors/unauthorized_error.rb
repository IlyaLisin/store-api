# frozen_string_literal: true

class UnauthorizedError < BaseError
  def initialize(msg = 'unauthorized', http = 401, pointer: nil, meta: nil)
    super
  end
end
