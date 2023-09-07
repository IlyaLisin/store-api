# frozen_string_literal: true

class CreatePurchaseOrdersProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_orders_products, id: :uuid, comment: 'Orders and products many to many' do |t|
      t.integer :amount, null: false, default: 1, comment: 'Products ammount'
      t.references :purchase_order,
                   type: :uuid,
                   null: false,
                   foreign_key: true,
                   index: false,
                   comment: 'Reference to order'
      t.references :product, type: :uuid, null: false, foreign_key: true, comment: 'Reference to product'

      t.timestamps
    end

    add_index :purchase_orders_products, %i[purchase_order_id product_id],
              name: 'index_orders_products_on_purchase_order_id_and_product_id'
  end
end
