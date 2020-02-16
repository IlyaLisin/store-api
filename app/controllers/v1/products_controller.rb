# frozen_string_literal: true

module V1
  class ProductsController < ApplicationController
    def index
      products = Products::IndexQuery.call(Product, request)

      render json: ProductSerializer.new(products, meta: { count: products.without_pagination.count })
    end
  end
end
