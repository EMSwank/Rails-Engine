require 'rails_helper'

describe 'Merchants API' do
  context "GET /api/v1" do
    it 'returns a list of merchants' do
      create_list(:merchant, 3)

      get "/api/v1/merchants"

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)
      merchant = merchants.first

      expect(merchants.count).to eq(3)
      expect(merchant).to have_key(:name)
    end
    it 'returns a single merchant' do
      create(:merchant)

      get "/api/v1/merchant"

      expect(response).to be_successful
      expect(merchant).to have_key(:name)
    end
  end
end