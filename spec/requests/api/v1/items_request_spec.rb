require 'rails_helper'

describe 'Items API' do
  context 'Visit /api/v1/items.json' do
    it 'displays json list of all items' do
      create_list(:item, 5)

      get '/api/v1/items.json'

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.count).to eq(5)
    end
  end
  context 'Visit /api/v1/items/:id.json' do
    it 'displays a json item by item id' do
      id = create(:item).id

      get "/api/v1/items/#{id}.json"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items['id']).to eq(id)
    end
  end
end
