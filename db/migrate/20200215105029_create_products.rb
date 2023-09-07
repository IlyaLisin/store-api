# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products, id: :uuid, comment: 'Products' do |t|
      t.string :name, null: false, index: true, comment: 'Product name'
      t.integer :available_count, null: false, default: 0, comment: "Available product's count"
      t.integer :price, null: false, default: 0, comment: "Product's price"

      t.timestamps
    end
  end
end
