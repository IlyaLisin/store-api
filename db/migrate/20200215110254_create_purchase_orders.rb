# frozen_string_literal: true

class CreatePurchaseOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_orders, id: :uuid, comment: 'Orders' do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true, comment: 'Reference to user'

      t.timestamps
    end
  end
end
