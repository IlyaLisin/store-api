# frozen_string_literal: true

module Model
  class SingleValidationError < BaseError
    def initialize(msg = '', http = 422, pointer: nil)
      super
    end
  end
end
