require 'rails_helper'

describe 'Api for top x merchants by revenue' do
  context 'GET /api/v1/merchants/most_revenue?quantity=x' do
    it 'shows top merchants by revenue in json' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      merchant4 = create(:merchant)
      merchant5 = create(:merchant)

      invoice1 = create(:invoice, merchant_id: merchant1.id)
      invoice2 = create(:invoice, merchant_id: merchant2.id)
      invoice3 = create(:invoice, merchant_id: merchant3.id)
      invoice4 = create(:invoice, merchant_id: merchant4.id)
      invoice5 = create(:invoice, merchant_id: merchant5.id)

      transaction1 = create(:transaction, invoice_id: invoice1.id, result: 'success')
      transaction2 = create(:transaction, invoice_id: invoice2.id, result: 'success')
      transaction3 = create(:transaction, invoice_id: invoice3.id, result: 'success')
      transaction4 = create(:transaction, invoice_id: invoice4.id, result: 'success')
      transaction5 = create(:transaction, invoice_id: invoice5.id, result: 'success')

      invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 5, unit_price: 50)
      invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, quantity: 2, unit_price: 300)
      invoice_item3 = create(:invoice_item, invoice_id: invoice3.id, quantity: 10, unit_price: 100)
      invoice_item4 = create(:invoice_item, invoice_id: invoice4.id, quantity: 10, unit_price: 200)
      invoice_item5 = create(:invoice_item, invoice_id: invoice5.id, quantity: 5, unit_price: 100)

      get '/api/v1/merchants/most_revenue?quantity=3'

      expect(response).to be_successful

      merchants = JSON.parse(response.body)

      expect(merchants.first['id']).to eq(merchant4.id)
      expect(merchants.last['id']).to eq(merchant2.id)
    end
  end
end
