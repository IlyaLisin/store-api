# frozen_string_literal: true

module V1
  class ProductsController < ApplicationController
    # GET /v1/products
    def index
      products = Products::IndexQuery.call(Product, request)

      render json: ProductSerializer.new(products[:data], meta: products[:meta])
    end
  end
end
