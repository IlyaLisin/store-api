class CreatePurchaseOrdersProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_orders_products, id: :uuid, comment: 'Связь товаров и заказов' do |t|
      t.integer :amount, null: false, default: 1, comment: 'Количество единиц товара'
      t.references :purchase_order,
                   type: :uuid,
                   null: false,
                   foreign_key: true,
                   index: false,
                   comment: 'Ссылка на заказ'
      t.references :product, type: :uuid, null: false, foreign_key: true, comment: 'Ссылка на товар'

      t.timestamps
    end

    add_index :purchase_orders_products, %i[purchase_order_id product_id],
              name: 'index_orders_products_on_purchase_order_id_and_product_id'
  end
end
