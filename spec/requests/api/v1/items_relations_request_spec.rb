require 'rails_helper'

describe "API for Items Relationships" do
  context "GET /api/v1/items/:id/invoice_items" do
    it "returns a collection of invoice_items in json" do
      item = create(:item)
      invoice_item1 = create(:invoice_item, item_id: item.id)
      invoice_item2 = create(:invoice_item, item_id: item.id)
      invoice_item3 = create(:invoice_item, item_id: item.id)

      get "/api/v1/items/#{item.id}/invoice_items"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.length).to eq(3) 
    end
  end
  context "GET /api/v1/items/:id/merchant" do
    it "returns a merchant for items in json" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}/merchant"

      expect(response).to be_successful

      merch = JSON.parse(response.body)

      expect(merch["id"]).to eq(merchant.id) 
    end
  end
end
