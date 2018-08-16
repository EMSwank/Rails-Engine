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

    it 'finds updated at by query params' do
      updated_at = create(:merchant, updated_at: "2012-03-27 14:54:05 UTC" ).updated_at

      get "/api/v1/merchants/find?updated_at=#{updated_at}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["updated_at"]).to eq("2012-03-27T14:54:05.000Z")
    end
  end

  context "GET /api/v1/merchants/find_all?" do
    it 'finds all merchants by ID through query params' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)

      get "/api/v1/merchants/find_all?id=#{merchant1.id}"
      
      expect(response).to be_successful
      
      merchant = JSON.parse(response.body)

      expect(merchant.length).to eq(1)
    end

    it 'finds all merchants by name through query params' do
      name = create(:merchant).name

      get "/api/v1/merchants/find_all?name=#{name}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant[0]["name"]).to eq(name)
    end

    it 'finds all merchants by created_at through query params' do
      merchant1 = create(:merchant, created_at: "2012-03-27 14:56:35 UTC")
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)

      get "/api/v1/merchants/find_all?created_at=#{merchant1.created_at}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant[0]["id"]).to eq(merchant1.id)
    end

    it 'finds all merchants by updated_at through query params' do
      merchant1 = create(:merchant, updated_at: "2012-03-27 14:56:35 UTC")
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)

      get "/api/v1/merchants/find_all?updated_at=#{merchant1.updated_at}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant[0]["id"]).to eq(merchant1.id)
    end
  end

end