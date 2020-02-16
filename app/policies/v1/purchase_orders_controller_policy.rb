# frozen_string_literal: true

module V1
  class PurchaseOrdersControllerPolicy < AuthorizedUserPolicy
    def create?
      true
    end
  end
end
