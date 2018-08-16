require 'rails_helper'

describe "API customer relation endpoints" do
  context "GET /api/v1/customers/:id/invoices" do
    it "returns a collection of associated invoices" do
      customer = create(:customer)
      invoice1 = create(:invoice, customer_id: customer.id)
      invoice2 = create(:invoice, customer_id: customer.id)
      invoice3 = create(:invoice, customer_id: customer.id)

      get "/api/v1/customers/#{customer.id}/invoices"

      expect(response).to be_successful

      invoices = JSON.parse(response.body)

      expect(invoices.length).to eq(3)
      expect(invoices.first["id"]).to eq(invoice1.id)
      expect(invoices.last["id"]).to eq(invoice3.id)
    end
  end
  context "GET /api/v1/customers/:id/transactions" do
    it "returns a collection of associated transactions" do
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id)
      trans1 = create(:transaction, invoice_id: invoice.id)
      trans2 = create(:transaction, invoice_id: invoice.id)
      trans3 = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/customers/#{customer.id}/transactions"

      expect(response).to be_successful

      transactions = JSON.parse(response.body)

      expect(transactions.length).to eq(3)
      expect(transactions.first["id"]).to eq(trans1.id)
      expect(transactions.last["id"]).to eq(trans3.id)
    end
  end
end
