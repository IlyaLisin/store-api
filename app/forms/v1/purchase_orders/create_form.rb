# frozen_string_literal: true

module V1
  module PurchaseOrders
    class CreateForm < JSONAPIForm::Base
      TYPE = 'purchase_order'

      RELATIONSHIPS = {
        purchase_orders_products: { class_name: OrdersProductForm.name, is_collection: true }
      }.freeze

      validates_presence_of :purchase_orders_products
    end
  end
end
