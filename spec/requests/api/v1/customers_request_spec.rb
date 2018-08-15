require 'rails_helper'

describe 'Customers API' do
  context "GET /api/v1" do
    it 'returns a list of customers' do
      create_list(:customer, 3)

      get "/api/v1/merchants"

      customers = JSON.parse(response.body, symbolize_names: true)
      customer = customers.first

      expect(customers.count).to eq(3)
      expect(customer).to have_key(:first_name)
      expect(customer).to have_key(:last_name)
    end
  end
end