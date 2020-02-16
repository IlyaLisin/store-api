# frozen_string_literal: true

module V1
  class PurchaseOrdersController < ApplicationController
    def create
      order = V1::PurchaseOrders::CreateQuery.call(nil, request)

      render json: PurchaseOrderSerializer.new(order)
    end
  end
end
