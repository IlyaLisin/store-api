# frozen_string_literal: true

module V1
  class PurchaseOrdersController < ApplicationController
    # POST   /v1/purchase_orders
    def create
      order = V1::PurchaseOrders::CreatePurchaseOrder.call!(params: params.permit!.to_h).order

      render json: PurchaseOrderSerializer.new(order)
    end
  end
end
