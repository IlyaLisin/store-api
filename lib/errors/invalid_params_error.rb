# frozen_string_literal: true

class InvalidParamsError < BaseError
  def initialize(msg = '', http = 400)
    super
  end
end
