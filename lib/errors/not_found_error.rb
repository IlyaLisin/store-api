# frozen_string_literal: true

class NotFoundError < BaseError
  def initialize(msg = 'not found', http = 404, **options)
    super(msg, http, **options)
  end
end
