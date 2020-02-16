# frozen_string_literal: true

class PurchaseOrderSerializer
  include FastJsonapi::ObjectSerializer

  has_many :purchase_orders_products
end
