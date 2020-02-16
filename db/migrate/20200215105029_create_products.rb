class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products, id: :uuid, comment: 'Товары' do |t|
      t.string :name, null: false, index: true, comment: 'Название товара'
      t.integer :available_count, null: false, default: 0, comment: 'Доступное количество товара'
      t.integer :price, null: false, default: 0, comment: 'Цена товара'

      t.timestamps
    end
  end
end
