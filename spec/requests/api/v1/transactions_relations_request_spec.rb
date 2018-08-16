require 'rails_helper'

describe "API transactions relations" do
  context "GET /api/v1/transactions/:id/invoice" do
    it "returns the associated invoice" do
      invoice = create(:invoice)
      transaction = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/transactions/#{transaction.id}/invoice"

      expect(response).to be_successful

      inv = JSON.parse(response.body)

      expect(inv["id"]).to eq(invoice.id)
    end
  end
end
