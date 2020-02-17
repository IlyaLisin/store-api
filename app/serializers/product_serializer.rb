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

class ProductSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :available_count, :price
end
