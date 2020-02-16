# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :email, :phone

  has_many :purchase_orders,
           record_type: :purchase_order,
           serializer: PurchaseOrderSerializer
end
