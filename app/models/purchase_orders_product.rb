# frozen_string_literal: true

class PurchaseOrdersProduct < ApplicationRecord
  belongs_to :product
  belongs_to :purchase_order

  validate :check_products_count
  after_save :update_products_count

  private

  def check_products_count
    errors.add(:amount, 'available count is too low') if product.available_count < amount
  end

  def update_products_count
    product.decrement!(:available_count, amount)
  end
end
