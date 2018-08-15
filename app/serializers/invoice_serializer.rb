class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :customer_id, :merchant_id, :status

  has_many :items
end
