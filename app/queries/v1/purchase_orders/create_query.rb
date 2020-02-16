# frozen_string_literal: true

module V1
  module PurchaseOrders
    class CreateQuery < ApplicationQuery
      def call
        form = CreateForm.new(params)
        form.validate!

        CreatePurchaseOrder.call!(form: form).order.reload
      end
    end
  end
end
