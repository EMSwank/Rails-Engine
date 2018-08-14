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
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["id"]).to eq(id)
    end

    it 'finds id by query params' do
      id = create(:merchant).id

      get "/api/v1/merchants/find?id=#{id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["id"]).to eq(id)
    end
    it 'finds name by query params' do
      name = create(:merchant).name

      get "/api/v1/merchants/find?name=#{name}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["name"]).to eq(name)
    end

    it 'finds created at by query params' do
      created_at = create(:merchant, created_at: "2012-03-27 14:54:05 UTC" ).created_at

      get "/api/v1/merchants/find?created_at=#{created_at}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["created_at"]).to eq("2012-03-27T14:54:05.000Z")
    end
  end
end