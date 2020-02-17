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

class PurchaseOrderSerializer
  include FastJsonapi::ObjectSerializer

  has_many :purchase_orders_products
end
