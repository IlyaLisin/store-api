# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :uuid             not null, primary key
#  name            :string           not null
#  available_count :integer          default(0), not null
#  price           :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Product < ApplicationRecord
  include Paginable

  validates_presence_of :name

  has_many :purchase_orders_products, dependent: :destroy
  has_many :purchase_orders, through: :purchase_orders_products
end
