require 'rails_helper'

describe 'Api for index business logic' do
  context 'GET /api/v1/items/most_revenue?quantity=x' do
    it 'returns api for the top items ranked by revenue' do
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)

      invoice1 = create(:invoice)
      invoice2 = create(:invoice)

      invoice_item = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, unit_price: 80, quantity: 4)
      invoice_item = create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, unit_price: 40, quantity: 20)
      invoice_item = create(:invoice_item, invoice_id: invoice1.id, item_id: item3.id, unit_price: 80, quantity: 2)

      transaction1 = create(:transaction, invoice_id: invoice1.id, result: 'success')
      transaction2 = create(:transaction, invoice_id: invoice2.id, result: 'success')

      expect(Item.most_revenue(3)).to eq([item2, item1, item3])

      get "/api/v1/items/most_revenue?quantity=3"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.length).to eq(3)
    end
    it 'returns api for the top items ranked by total sold' do
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)

      invoice1 = create(:invoice)
      invoice2 = create(:invoice)

      invoice_item = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, unit_price: 80, quantity: 4)
      invoice_item = create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, unit_price: 40, quantity: 20)
      invoice_item = create(:invoice_item, invoice_id: invoice1.id, item_id: item3.id, unit_price: 80, quantity: 2)

      transaction1 = create(:transaction, invoice_id: invoice1.id, result: 'success')
      transaction2 = create(:transaction, invoice_id: invoice2.id, result: 'success')

      expect(Item.most_revenue(3)).to eq([item2, item1, item3])

      get "/api/v1/items/most_items?quantity=3"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.length).to eq(3)
    end
  end
end
