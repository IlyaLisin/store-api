# frozen_string_literal: true

module V1
  class ProductsControllerPolicy < ApplicationPolicy
    def index?
      true
    end
  end
end
