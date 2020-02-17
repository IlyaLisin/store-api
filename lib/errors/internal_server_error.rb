# frozen_string_literal: true

class InternalServerError < BaseError
  def initialize(msg = '', http = 500)
    super
  end
end
