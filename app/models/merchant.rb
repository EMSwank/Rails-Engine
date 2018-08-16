class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.most_revenue(x = 5)
    select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
    .joins(:transactions, :invoice_items)
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('revenue desc')
    .limit(x)
  end
end
