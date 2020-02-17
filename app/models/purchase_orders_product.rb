# frozen_string_literal: true

# == Schema Information
#
# Table name: purchase_orders_products
#
#  id                :uuid             not null, primary key
#  amount            :integer          default(1), not null
#  purchase_order_id :uuid             not null
#  product_id        :uuid             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

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
