# frozen_string_literal: true

class AuthorizedUserPolicy < ApplicationPolicy
  def initialize(user, record)
    raise UnauthorizedError, 'unauthorized' unless user

    super
  end
end
