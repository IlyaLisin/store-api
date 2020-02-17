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

FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    available_count { 10 }
    price { rand(10..50) }
  end
end
