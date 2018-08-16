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
  context 'GET /api/v1/items/find?parameters' do
    it 'displays a single json object by id' do
      id = create(:item).id

      get "/api/v1/items/find?id=#{id}"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item['id']).to eq(id)
    end
    it 'displays a single json object by name' do
      name = create(:item).name

      get "/api/v1/items/find?name=#{name}"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item['name']).to eq(name)
    end
    it 'displays a single json object by description' do
      desc = create(:item).description

      get "/api/v1/items/find?description=#{desc}"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item['description']).to eq(desc)
    end
    it 'displays a single json object by unit price' do
      create(:item, unit_price: 1701)
      uprice = '17.01'

      get "/api/v1/items/find?unit_price=#{uprice}"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item['unit_price']).to eq(uprice)
    end
    it 'displays a single json object by merchant_id' do
      merchant = create(:merchant)
      merch_id = create(:item, merchant_id: merchant.id).merchant_id

      get "/api/v1/items/find?merchant_id=#{merch_id}"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item['merchant_id']).to eq(merch_id)
    end
    it 'displays a single json object by created_at' do
      item = create(:item, created_at: "2012-03-09 08:57:21 UTC")

      get "/api/v1/items/find?created_at=#{item.created_at}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(item['created_at']).to eq("2012-03-09T08:57:21.000Z")
    end
    it 'displays a single json object by updated_at' do
      item_1 = create(:item, name: 'Chris', updated_at: "2012-03-09 08:57:21 UTC")

      get "/api/v1/items/find?updated_at=#{item_1.updated_at}"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item['name']).to eq(item_1.name)
    end
  end
  context 'GET /api/v1/items/find_all?parameters' do
    it 'displays a all json objects by id' do
      item_1 = create(:item, id: 1)
      item_2 = create(:item, id: 2)
      item_3 = create(:item, id: 3)

      get "/api/v1/items/find_all?id=#{item_1.id}"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item.length).to eq(1)
    end
    it 'displays a all json objects by name' do
      item_1 = create(:item, name: 'hkjdhfadhfakhfa')
      item_2 = create(:item, name: 'hkjdhfadhfakhfa')
      item_3 = create(:item, name: '08ygvo')
      item_4 = create(:item, name: 'hkjdhfadhfakhfa')

      get "/api/v1/items/find_all?name=#{item_1.name}"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.length).to eq(3)
      expect(items.first['name']).to eq(item_1.name)
      expect(items.last['name']).to eq(item_4.name)
    end
    it 'displays all json objects by description' do
      desc_one = create(:item, description: 'So Fresh')
      desc_two = create(:item, description: 'So Fresh')
      desc_three = create(:item, description: 'Not So Fresh')
      desc_four = create(:item, description: 'So Fresh')

      get "/api/v1/items/find_all?description=#{desc_one.description}"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.length).to eq(3)
      expect(items.first['description']).to eq(desc_one.description)
      expect(items.last['description']).to eq(desc_four.description)
    end
    it 'displays all json objects by merchant_id' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant.id)
      item_3 = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/find_all?merchant_id=#{item_1.merchant_id}"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item.length).to eq(3)
      expect(item.first['merchant_id']).to eq(item_1.merchant_id)
      expect(item.last['merchant_id']).to eq(item_3.merchant_id)
    end
    it 'displays all json objects by unit_price' do
      item_1 = create(:item, unit_price: 46605)
      item_2 = create(:item, unit_price: 46605)
      item_3 = create(:item, unit_price: 46498)
      item_4 = create(:item, unit_price: 46605)
      price = '466.05'

      get "/api/v1/items/find_all?unit_price=#{price}"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.length).to eq(3)
      expect(items.first['unit_price']).to eq(price)
      expect(items.last['unit_price']).to eq(price)
    end
    it 'displays all json objects by created_at' do
      item_1 = create(:item, name: 'lkjhfgdaf', created_at: "2012-03-09 08:57:21 UTC")
      item_2 = create(:item, name: 'lkjhfgda ljbdf', created_at: "2012-03-09 08:57:21 UTC")

      get "/api/v1/items/find_all?created_at=#{item_1.created_at}"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.length).to eq(2)
      expect(items.first['name']).to eq(item_1.name)
      expect(items.last['name']).to eq(item_2.name)
    end
    it 'displays all json objects by updated_at' do
      item_1 = create(:item, name: ';iduyfniua', updated_at: "2012-03-09 08:57:21 UTC")
      item_2 = create(:item, name: 'uidyduyudyuduyfniua', updated_at: "2012-03-09 08:57:21 UTC")

      get "/api/v1/items/find_all?updated_at=#{item_1.updated_at}"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item.length).to eq(2)
      expect(item.first['name']).to eq(item_1.name)
      expect(item.last['name']).to eq(item_2.name)
    end
  end
end
