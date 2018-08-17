require 'rails_helper'

describe 'API for customer favorite merchant' do
  context 'GET api/v1/customers/:id/favorite_merchant' do
    it 'returns a merchant for the customer\'s most successful transactions' do
      customer = create(:customer)

      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      invoice1 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
      invoice2 = create(:invoice, merchant_id: merchant1.id, customer_id: customer.id)
      invoice3 = create(:invoice, merchant_id: merchant2.id, customer_id: customer.id)

      trans1 = create(:transaction, invoice_id: invoice1.id, result: 'success')
      trans2 = create(:transaction, invoice_id: invoice2.id, result: 'success')
      trans3 = create(:transaction, invoice_id: invoice3.id, result: 'success')

      get "/api/v1/customers/#{customer.id}/favorite_merchant"

      expect(response).to be_successful

      merch = JSON.parse(response.body)

      expect(merch['id']).to eq(merchant1.id)
    end
  end
end
