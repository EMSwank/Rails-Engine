require 'rails_helper'

describe "Transactions API" do
  context "GET /api/v1" do
    it "returns a list of transactions" do
      invoice = create(:invoice)
      create_list(:transaction, 3, invoice_id: invoice.id)

byebug

      get "/api/v1/transactions"

      expect(response).to be_successful

      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction = transaction.first

      expect(transactions.count).to eq(3)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:credit_card_expiration_date)
      expect(transaction).to have_key(:result)
    end
  end
end
