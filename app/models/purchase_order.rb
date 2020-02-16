# frozen_string_literal: true

class PurchaseOrder < ApplicationRecord
  include Paginable

  belongs_to :user
  has_many :purchase_orders_products, dependent: :destroy
  has_many :products, through: :purchase_orders_products
end
