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
end
