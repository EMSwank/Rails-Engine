require 'rails_helper'

describe "API for Merchants Relations" do
  context "GET /api/v1/merchants/:id/items" do
    it "shows a list of items in json" do
      merchant = create(:merchant)
      items1 = create(:item, merchant_id: merchant.id)
      items2 = create(:item, merchant_id: merchant.id)
      items3 = create(:item, merchant_id: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/items"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.length).to eq(3)
      expect(items.first["id"]).to eq(items1.id)
      expect(items.last["id"]).to eq(items3.id)
    end
  end
  context "GET /api/v1/merchants/:id/invoice" do
    it "shows a list of invoice in json" do
      merchant = create(:merchant)
      invoice1 = create(:invoice, merchant_id: merchant.id)
      invoice2 = create(:invoice, merchant_id: merchant.id)
      invoice3 = create(:invoice, merchant_id: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/invoices"

      expect(response).to be_successful

      invoices = JSON.parse(response.body)

      expect(invoices.length).to eq(3)
      expect(invoices.first["id"]).to eq(invoice1.id)
      expect(invoices.last["id"]).to eq(invoice3.id)
    end
  end
end
