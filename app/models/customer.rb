class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  has_many :invoice_items, through: :invoices

  def favorite_merchant
    merchants.select('merchants.*, count(transactions.result) as trans').
    joins(invoices: :transactions).
    where(transactions: {result: "success"}).
    group(:id).order('trans desc').
    limit(1)[0]
  end
end
