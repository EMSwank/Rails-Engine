require 'rails_helper'

describe 'Customers API' do
  context "GET /api/v1" do
    it 'returns a list of customers' do
      create_list(:customer, 3)

      get "/api/v1/customers"

      expect(response).to be_successful

      customers = JSON.parse(response.body, symbolize_names: true)
      customer = customers.first

      expect(customers.count).to eq(3)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
    end

    it 'returns a single customer' do
      id = create(:customer).id

      get "/api/v1/customers/#{id}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer["id"]).to eq(id)
    end

    it 'finds ID through query params' do
      id = create(:customer).id

      get "/api/v1/customers/find?id=#{id}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer["id"]).to eq(id)
    end

    it 'finds first_name through query params' do
      name = create(:customer).first_name

      get "/api/v1/customers/find?first_name=#{name}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer["first_name"]).to eq(name)
    end

    it 'finds last_name through query params' do
      name = create(:customer).last_name

      get "/api/v1/customers/find?last_name=#{name}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer["last_name"]).to eq(name)
    end

    it 'finds created_at by query params' do
      created_at = create(:customer, created_at: "2012-03-27 14:56:35 UTC" ).created_at

      get "/api/v1/customers/find?created_at=#{created_at}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer["created_at"]).to eq("2012-03-27T14:56:35.000Z")
    end

    it 'finds updated_at by query params' do
      updated_at = create(:customer, updated_at: "2012-03-27 14:56:35 UTC" ).updated_at

      get "/api/v1/customers/find?updated_at=#{updated_at}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer["updated_at"]).to eq("2012-03-27T14:56:35.000Z")
    end

  end
end