require 'rails_helper'

RSpec.describe Customer, type: :model do
    it { should have_many(:invoices) }
    it { should have_many(:merchants).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  describe 'instance method' do
    it 'can find a favorite merchant' do
      customer = create(:customer)

      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
      invoice2 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
      invoice3 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)

      trans1 = create(:transaction, invoice_id: invoice1.id, result: 'success')
      trans2 = create(:transaction, invoice_id: invoice2.id, result: 'success')
      trans3 = create(:transaction, invoice_id: invoice3.id, result: 'success')

      expect(customer.favorite_merchant).to eq(merchant1)
    end
  end
end
