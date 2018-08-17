class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.most_revenue(x = 5)
    select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
    .joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('revenue desc')
    .limit(x)
  end

  def self.most_items_sold(x = 5)
    select('merchants.*, sum(invoice_items.quantity) as item_count')
    .joins(invoices: [:transactions, :invoice_items])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('item_count desc')
    .limit(x)
  end

  def self.total_revenue_for_date(date)
    joins(invoices: [:transactions, :invoice_items]).
    where(transactions: {result: 'success'}).
    where(invoices: {updated_at: date.beginning_of_day..date.end_of_day}).
    sum('quantity * unit_price')
  end

  def successful_transactions_total
    invoices.
    joins(:transactions, :invoice_items).
    where(transactions: {result: 'success'}).
    sum('quantity * unit_price')
  end

  def revenue_by_date(date)
    invoices.
    joins(:transactions, :invoice_items).
    where(transactions: {result: 'success'}).
    where(invoices: {updated_at: date.beginning_of_day..date.end_of_day}).
    sum('quantity * unit_price')
  end

  def favorite_customer
    customers.
    select('customers.*, count(transactions.result) as trans').
    joins(invoices: :transactions).where(transactions: {result: 'success'}).
    group(:id).
    order('trans desc').
    limit(1)[0]
  end
end
