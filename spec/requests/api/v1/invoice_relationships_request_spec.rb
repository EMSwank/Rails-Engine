require 'rails_helper'

describe 'Api for invoice relationships' do
  context 'GET /api/v1/invoices/:id/merchant' do
    it 'displays a merchant for a specific invoice' do
      merchant = create(:merchant)
      invoice  = create(:invoice, merchant_id: merchant.id)

      get "/api/v1/invoices/#{invoice.id}/merchant"

      expect(response).to be_successful

      merch = JSON.parse(response.body)

      expect(merch['id']).to eq(merchant.id)
    end
  end
  context 'GET /api/v1/invoices/:id/customer' do
    it 'displays a merchant for a specific invoice' do
      customer = create(:customer)
      invoice  = create(:invoice, customer_id: customer.id)

      get "/api/v1/invoices/#{invoice.id}/customer"

      expect(response).to be_successful

      cust = JSON.parse(response.body)

      expect(cust['id']).to eq(customer.id)
    end
  end
end
