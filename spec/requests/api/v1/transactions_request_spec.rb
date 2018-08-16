require 'rails_helper'

describe "Transactions API" do
  context "GET /api/v1" do
    it "returns a list of transactions" do
      invoice = create(:invoice)
      3.times do
        create(:transaction, invoice_id: invoice.id)
      end

      get "/api/v1/transactions"

      expect(response).to be_successful

      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction = transactions.first

      expect(transactions.count).to eq(3)
      expect(transaction).to have_key(:invoice_id)
      expect(transaction).to have_key(:credit_card_number)
      expect(transaction).to have_key(:result)
    end

    it 'returns a single transaction' do
      invoice = create(:invoice)
      id = create(:transaction, invoice_id: invoice.id).id

      get "/api/v1/transactions/#{id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction["id"]).to eq(id)

    end

    it 'finds ID through query params' do
      invoice = create(:invoice)
      id = create(:transaction, invoice_id: invoice.id).id

      get "/api/v1/transactions/find?id=#{id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction["id"]).to eq(id)

    end

    it 'finds credit_card_numbers through query params' do
      invoice = create(:invoice)
      cc_num = create(:transaction, invoice_id: invoice.id).credit_card_number

      get "/api/v1/transactions/find?credit_card_number=#{cc_num}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction["credit_card_number"]).to eq(cc_num)

    end

    it 'finds result through query params' do
      invoice = create(:invoice)
      result = create(:transaction, invoice_id: invoice.id).result

      get "/api/v1/transactions/find?result=#{result}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction["result"]).to eq(result)

    end
  end
end
