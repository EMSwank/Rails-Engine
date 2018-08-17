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
      cc_num = create(:transaction, invoice_id: invoice.id).credit_card_number.to_s

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

    it 'finds result through created_at params' do
      invoice = create(:invoice)
      transaction1 = create(:transaction, invoice_id: invoice.id, created_at: "2012-03-27 14:56:35 UTC")
      transaction2 = create(:transaction, invoice_id: invoice.id)
      transaction3 = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/transactions/find?created_at=#{transaction1.created_at}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction["id"]).to eq(transaction1.id)

    end

    it 'finds result through updated_at params' do
      invoice = create(:invoice)
      transaction1 = create(:transaction, invoice_id: invoice.id, updated_at: "2012-03-27 14:56:35 UTC")
      transaction2 = create(:transaction, invoice_id: invoice.id)
      transaction3 = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/transactions/find?updated_at=#{transaction1.updated_at}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction["id"]).to eq(transaction1.id)

    end
  end
  context "GET /api/v1/transactions/find_all?" do
    it 'finds all ids through find_all query params' do
      invoice = create(:invoice)
      id1 = create(:transaction, invoice_id: invoice.id).id
      id2 = create(:transaction, invoice_id: invoice.id).id
      id3 = create(:transaction, invoice_id: invoice.id).id

      get "/api/v1/transactions/find_all?id=#{id1}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction.length).to eq(1)

    end

    it 'finds all invoice_ids through find_all query params' do
      invoice = create(:invoice)
      transaction = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/transactions/find_all?invoice_id=#{invoice.id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction[0]["invoice_id"]).to eq(invoice.id)
    end

    it 'finds all by credit_card_number' do
      invoice = create(:invoice)
      transaction = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/transactions/find_all?credit_card_number=#{transaction.credit_card_number.to_s}"

      response_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(response_body[0]["credit_card_number"]).to eq(transaction.credit_card_number.to_s)
    end

    it 'finds all by result' do
      invoice = create(:invoice)
      transaction = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/transactions/find_all?result=#{transaction.result}"

      response_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(response_body[0]["result"]).to eq(transaction.result)
    end

    it 'finds all by created_at' do
      invoice = create(:invoice)
      transaction = create(:transaction, invoice_id: invoice.id, created_at: "2012-03-27 14:56:35 UTC")

      get "/api/v1/transactions/find_all?created_at=#{transaction.created_at}"

      response_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(response_body[0]["id"]).to eq(transaction.id)
    end

    it 'finds all by updated_at' do
      invoice = create(:invoice)
      transaction = create(:transaction, invoice_id: invoice.id, updated_at: "2012-03-27 14:56:35 UTC")

      get "/api/v1/transactions/find_all?updated_at=#{transaction.updated_at}"

      response_body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(response_body[0]["id"]).to eq(transaction.id)
    end
    it 'finds and returns a random Transaction' do
      invoice      = create(:invoice)
      transaction1 = create(:transaction, invoice_id: invoice.id)
      transaction2 = create(:transaction, invoice_id: invoice.id)
      transaction3 = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/transactions/random"

      expect(response).to be_successful

      transaction = JSON.parse(response.body)

      expect(transaction.values.count).to eq(4)
    end
  end
end
