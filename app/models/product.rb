# frozen_string_literal: true

class Product < ApplicationRecord
  include Paginable

  validates_presence_of :name

  has_many :purchase_orders_products, dependent: :destroy
  has_many :purchase_orders, through: :purchase_orders_products
end
