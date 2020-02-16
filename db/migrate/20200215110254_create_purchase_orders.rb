class CreatePurchaseOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_orders, id: :uuid, comment: 'Заказы' do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true, comment: 'Ссылка на юзера'

      t.timestamps
    end
  end
end
