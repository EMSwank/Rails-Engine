class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.most_expensive(limit = 5)
    select("invoices.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").
    joins(:transactions, :invoice_items).
    where(transactions: {result: "success"}).
    group(:id).
    order("revenue DESC").
    limit(limit)
  end
  
end
