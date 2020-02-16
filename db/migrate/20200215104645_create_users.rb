class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid, comment: 'Пользователи' do |t|
      t.string :name
      t.string :phone, null: true, index: { unique: true }
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false

      t.string :reset_password_token, index: { unique: true }
      t.datetime :reset_password_sent_at

      t.string   :confirmation_token, index: { unique: true }
      t.datetime :confirmation_sent_at
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
