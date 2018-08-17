class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.most_revenue(x = 5)
    select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue').
    joins(invoices: :transactions).
    where(transactions: {result: 'success'}).
    group(:id).
    order('revenue desc').
    limit(x)
  end

  def self.most_sold(x = 5)
    select('items.*, sum(invoice_items.quantity) as total_sold').
    joins(invoices: :transactions).
    where(transactions: {result: 'success'}).
    group(:id).
    order('total_sold desc').
    limit(x)
  end

  def best_day
    invoices.
    select('invoices.*, count(invoices.*) as total_sales').
    joins(:transactions).where(transactions: {result: 'success'}).
    group(:id).
    order('total_sales desc').
    order('updated_at desc').first.updated_at
  end
end
