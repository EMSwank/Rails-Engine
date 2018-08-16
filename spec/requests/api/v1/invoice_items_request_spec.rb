require 'rails_helper'

describe 'Invoice Items API' do
  context 'GET /api/v1/invoice_items.json' do
    it 'gets and index of all invoice items in json' do
      create_list(:invoice_item, 3)

      get '/api/v1/invoice_items.json'

      expect(response).to be_successful

      list = JSON.parse(response.body)

      expect(list.length).to eq(3)
    end
  end
end
