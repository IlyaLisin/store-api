# frozen_string_literal: true

require 'faker'

def users
  users = []

  10.times do
    users << {
      name: Faker::Movies::Hobbit.character,
      email: Faker::Internet.email,
      password: '12345',
      confirmed_at: Time.current
    }
  end

  User.create!(users)
end

def products
  products = []

  20.times do
    products << {
      name: Faker::Book.title,
      available_count: rand(1..10),
      price: rand(10..100)
    }
  end

  Product.create!(products)
end

def purchase_orders
  po = []

  5.times do
    po << { user: User.all.sample }
  end

  PurchaseOrder.create!(po)

  PurchaseOrder.all.each do |o|
    products = Product.all.sample(2)
    products.each do |p|
      PurchaseOrdersProduct.create!(
        purchase_order: o,
        product: p,
        amount: products.sum(&:price)
      )
    end
  end
end

users
products
purchase_orders
