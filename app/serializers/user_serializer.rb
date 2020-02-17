# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  name                   :string
#  phone                  :string
#  email                  :string           not null
#  password_digest        :string           not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  confirmation_token     :string
#  confirmation_sent_at   :datetime
#  confirmed_at           :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :email, :phone

  has_many :purchase_orders,
           record_type: :purchase_order,
           serializer: PurchaseOrderSerializer
end
