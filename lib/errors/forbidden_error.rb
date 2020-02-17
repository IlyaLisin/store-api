# frozen_string_literal: true

class ForbiddenError < BaseError
  def initialize(msg = 'forbidden', http = 403)
    super
  end
end
