# frozen_string_literal: true

module V1
  module PurchaseOrders
    class CreateForm < BaseForm
      TYPE = 'purchase_order'

      RELATIONSHIPS = {
          'purchase_orders_products' => OrdersProductForm,
      }.freeze

      attr_accessor(*RELATIONSHIPS.keys)

      def initialize(args)
        @without_attributes = true
        super(args)
      end

      validates_presence_of :purchase_orders_products
    end
  end
end
