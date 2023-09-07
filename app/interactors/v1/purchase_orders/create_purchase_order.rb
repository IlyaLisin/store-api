# frozen_string_literal: true

module V1
  module PurchaseOrders
    class CreatePurchaseOrder
      include Interactor

      delegate :params, :form, to: :context

      before do
        context.form = CreateForm.new(params)
        form.validate!
      end

      def call
        ActiveRecord::Base.transaction do
          context.order = PurchaseOrder.create!(user: Current.user)

          PurchaseOrdersProduct.create!(purchase_orders_products)
        end

        context.order.reload
      end

      private

      def purchase_orders_products
        attributes = []

        form.purchase_orders_products.each do |product_form|
          product = find_product!(product_form.product_id)

          attributes << {
            product_id: product.id,
            purchase_order_id: context.order.id,
            amount: product_form.amount
          }
        end

        attributes
      end

      def find_product!(id)
        product = Product.find_by_id(id)

        raise Model::SingleValidationError, 'Products not found' unless product

        product
      end
    end
  end
end
