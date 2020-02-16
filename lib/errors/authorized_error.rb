# frozen_string_literal: true

class AuthorizedError < ForbiddenError
  def initialize(msg = 'forbidden', http = 403)
    super
  end
end
