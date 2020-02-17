# frozen_string_literal: true

# == Schema Information
#
# Table name: purchase_orders
#
#  id         :uuid             not null, primary key
#  user_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PurchaseOrder < ApplicationRecord
  include Paginable

  belongs_to :user
  has_many :purchase_orders_products, dependent: :destroy
  has_many :products, through: :purchase_orders_products
end
