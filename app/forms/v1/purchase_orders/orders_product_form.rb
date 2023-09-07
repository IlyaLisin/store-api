# frozen_string_literal: true

module V1
  module PurchaseOrders
    class OrdersProductForm < JSONAPIForm::Base
      TYPE = 'purchase_orders_product'

      ATTRIBUTES = %w[
        product_id
        amount
      ].freeze

      validates_presence_of :product_id, :amount

      validates_type :product_id, :string
      validates_type :amount, :integer
    end
  end
end
