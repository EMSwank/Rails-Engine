class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.most_revenue(x = 3)
    select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue').
    joins(invoices: :transactions).
    where(transactions: {result: 'success'}).
    group(:id).
    order('revenue desc')
  end
end
