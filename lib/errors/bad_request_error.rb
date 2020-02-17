# frozen_string_literal: true

class BadRequestError < BaseError
  def initialize(msg = '', http = 400)
    super
  end
end
