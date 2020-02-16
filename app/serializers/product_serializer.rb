# frozen_string_literal: true

class ProductSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :available_count, :price
end
