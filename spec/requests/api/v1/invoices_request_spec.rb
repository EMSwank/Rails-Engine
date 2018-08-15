require 'rails_helper'

describe 'Invoices API' do
  context 'GET /api/v1/invoices.json' do
    it 'displays all json list of invoices' do
      create_list(:invoice, 3)

      get '/api/v1/invoices.json'

      expect(response).to be_successful

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(3)
    end
  end
  context 'GET /api/v1/invoices/:id.json' do
    it 'displays a single json object' do
      id = create(:invoice).id

      get "/api/v1/invoices/#{id}.json"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice['id']).to eq(id)
    end
  end
  context 'GET /api/v1/invoices/find?parameters' do
    it 'displays a single json object by id' do
      id = create(:invoice).id

      get "/api/v1/invoices/find?id=#{id}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice['id']).to eq(id)
    end
    it 'displays a single json object by customer_id' do
      c_id = create(:invoice).customer_id

      get "/api/v1/invoices/find?customer_id=#{c_id}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice['customer_id']).to eq(c_id)
    end
    it 'displays a single json object by merchant_id' do
      m_id = create(:invoice).merchant_id

      get "/api/v1/invoices/find?merchant_id=#{m_id}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice['merchant_id']).to eq(m_id)
    end
    it 'displays a single json object by status' do
      stts = create(:invoice).status

      get "/api/v1/invoices/find?status=#{stts}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice['status']).to eq(stts)
    end
    it 'displays a single json object by created_at' do
      invoice_thing = create(:invoice, created_at: "2012-03-09 08:57:21 UTC")

      get "/api/v1/invoices/find?created_at=#{invoice_thing.created_at}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice['created_at']).to eq("2012-03-09T08:57:21.000Z")
    end
    it 'displays a single json object by updated_at' do
      invoice_thing = create(:invoice, updated_at: "2012-03-09 08:57:21 UTC")

      get "/api/v1/invoices/find?updated_at=#{invoice_thing.updated_at}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice['updated_at']).to eq("2012-03-09T08:57:21.000Z")
    end
  end
  context 'GET /api/v1/invoices/find_all?parameters' do
    it 'displays a all json objects by id' do
      invoice_1 = create(:invoice, id: 1)
      invoice_2 = create(:invoice, id: 2)
      invoice_3 = create(:invoice, id: 3)

      get "/api/v1/invoices/find_all?id=1"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice.length).to eq(1)
    end
    it 'displays all json objects by customer_id' do
      customer = create(:customer)
      create(:invoice, customer_id: customer.id)
      create(:invoice, customer_id: customer.id)
      create(:invoice, customer_id: customer.id)

      get "/api/v1/invoices/find_all?customer_id=#{customer.id}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice.length).to eq(3)
      expect(invoice.first['customer_id']).to eq(customer.id)
      expect(invoice.last['customer_id']).to eq(customer.id)
    end
    it 'displays all json objects by merchant_id' do
      merchant = create(:merchant)
      create(:invoice, merchant_id: merchant.id)
      create(:invoice, merchant_id: merchant.id)
      create(:invoice, merchant_id: merchant.id)

      get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice.length).to eq(3)
      expect(invoice.first['merchant_id']).to eq(merchant.id)
      expect(invoice.last['merchant_id']).to eq(merchant.id)
    end
    it 'displays all json objects by status' do
      inv_1 = create(:invoice, status: 'shipped')
      inv_2 = create(:invoice, status: 'shipped')
      inv_3 = create(:invoice, status: 'shipped')
      inv_4 = create(:invoice, status: 'shipped')

      get "/api/v1/invoices/find_all?status=shipped"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice.length).to eq(4)
      expect(invoice.first['status']).to eq(inv_1.status)
      expect(invoice.last['status']).to eq(inv_4.status)
    end
    it 'displays all json objects by created_at' do
      inv_1 = create(:invoice, created_at: "2012-03-09 08:57:21 UTC")
      inv_2 = create(:invoice, created_at: "2012-03-09 08:57:21 UTC")

      get "/api/v1/invoices/find_all?created_at=#{inv_1.created_at}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice.length).to eq(2)
      expect(invoice.first['created_at']).to eq("2012-03-09T08:57:21.000Z")
      expect(invoice.last['created_at']).to eq("2012-03-09T08:57:21.000Z")
    end
    it 'displays all json objects by updated_at' do
      inv_1 = create(:invoice, updated_at: "2012-03-09 08:57:21 UTC")
      inv_2 = create(:invoice, updated_at: "2012-03-09 08:57:21 UTC")

      get "/api/v1/invoices/find_all?updated_at=#{inv_1.updated_at}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice.length).to eq(2)
      expect(invoice.first['updated_at']).to eq("2012-03-09T08:57:21.000Z")
      expect(invoice.last['updated_at']).to eq("2012-03-09T08:57:21.000Z")
    end
  end
end
