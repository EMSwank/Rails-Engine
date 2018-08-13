require 'rails_helper'

describe 'Merchants API' do
  context "GET /api/v1" do
    it 'returns a list of merchants' do
      get "/api/v1/merchants"

      expect(response).to be_successful
      expect(merchants.count).to eq(3)
      expect(merchant).to have_key(:name)
    end
  end
  
end