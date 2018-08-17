require 'rails_helper'

describe 'Invoice Items API' do
  context 'GET /api/v1/invoice_items.json' do
    it 'displays an index of all invoice items in json' do
      create_list(:invoice_item, 3)

      get '/api/v1/invoice_items.json'

      expect(response).to be_successful

      list = JSON.parse(response.body)

      expect(list.length).to eq(3)
    end
  end
  context 'GET /api/v1/invoice_items/:id.json' do
    it 'displays a single invoice item in json' do
      id = create(:invoice_item).id

      get "/api/v1/invoice_items/#{id}.json"

      expect(response).to be_successful

      list = JSON.parse(response.body)

      expect(list['id']).to eq(id)
    end
  end
  context 'GET /api/v1/invoice_items/find?parameters' do
    it 'displays a single json object by id' do
      id = create(:invoice_item).id

      get "/api/v1/invoice_items/find?id=#{id}"

      expect(response).to be_successful

      inv_item = JSON.parse(response.body)

      expect(inv_item['id']).to eq(id)
    end
    it 'displays a single json object by item_id' do
      i_id = create(:invoice_item).item_id

      get "/api/v1/invoice_items/find?item_id=#{i_id}"

      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)

      expect(invoice_item['item_id']).to eq(i_id)
    end
    it 'displays a single json object by invoice_id' do
      inv_id = create(:invoice_item).invoice_id

      get "/api/v1/invoice_items/find?invoice_id=#{inv_id}"

      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)

      expect(invoice_item['invoice_id']).to eq(inv_id)
    end
    it 'displays a single json object by quangtity' do
      qty = create(:invoice_item).quantity

      get "/api/v1/invoice_items/find?quantity=#{qty}"

      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)

      expect(invoice_item['quantity']).to eq(qty)
    end
    it 'displays a single json object by unit_price' do
      i_item = create(:invoice_item, unit_price: 18765)
      uprice = "187.65"

      get "/api/v1/invoice_items/find?unit_price=#{uprice}"

      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)

      expect(invoice_item['unit_price']).to eq(uprice)
    end
    it 'displays a single json object by created_at' do
      i_item = create(:invoice_item, created_at: "2012-03-09 08:57:21 UTC")

      get "/api/v1/invoice_items/find?created_at=#{i_item.created_at}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(i_item['created_at']).to eq("2012-03-09T08:57:21.000Z")
    end
    it 'displays a single json object by updated_at' do
      i_item = create(:invoice_item, quantity: 7238, updated_at: "2012-03-09 08:57:21 UTC")

      get "/api/v1/invoice_items/find?updated_at=#{i_item.updated_at}"

      expect(response).to be_successful

      inv_item = JSON.parse(response.body)

      expect(inv_item['quantity']).to eq(i_item.quantity)
    end
  end
  context 'GET /api/v1/items/find_all?parameters' do
    it 'displays a all json objects by id' do
      invoice_item_1 = create(:invoice_item, id: 1)
      invoice_item_2 = create(:invoice_item, id: 2)
      invoice_item_3 = create(:invoice_item, id: 3)

      get "/api/v1/invoice_items/find_all?id=#{invoice_item_1.id}"

      expect(response).to be_successful

      i_item = JSON.parse(response.body)

      expect(i_item.length).to eq(1)
      expect(i_item.first['id']).to eq(invoice_item_1.id)
    end
    it 'displays a all json objects by invoice_id' do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)

      invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id)
      invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id)
      invoice_item_3 = create(:invoice_item, invoice_id: invoice_2.id)
      invoice_item_4 = create(:invoice_item, invoice_id: invoice_1.id)

      get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_item_1.invoice_id}"

      expect(response).to be_successful

      i_items = JSON.parse(response.body)

      expect(i_items.length).to eq(3)
      expect(i_items.first['invoice_id']).to eq(invoice_item_1.invoice_id)
      expect(i_items.last['invoice_id']).to eq(invoice_item_4.invoice_id)
    end
    it 'displays all json objects by quantity' do
      qty_one = create(:invoice_item, quantity: 643)
      qty_two = create(:invoice_item, quantity: 643)
      qty_three = create(:invoice_item, quantity: 21)
      qty_four = create(:invoice_item, quantity: 643)

      get "/api/v1/invoice_items/find_all?quantity=#{qty_one.quantity}"

      expect(response).to be_successful

      i_items = JSON.parse(response.body)

      expect(i_items.length).to eq(3)
      expect(i_items.first['quantity']).to eq(qty_one.quantity)
      expect(i_items.last['quantity']).to eq(qty_four.quantity)
    end
    it 'displays all json objects by unit price' do
      inv_item_1 = create(:invoice_item, unit_price: 34505)
      inv_item_2 = create(:invoice_item, unit_price: 75645)
      inv_item_3 = create(:invoice_item, unit_price: 34505)
      u_price = "345.05"

      get "/api/v1/invoice_items/find_all?unit_price=#{u_price}"

      expect(response).to be_successful

      i_item = JSON.parse(response.body)

      expect(i_item.length).to eq(2)
      expect(i_item.first['unit_price']).to eq(u_price)
      expect(i_item.last['unit_price']).to eq(u_price)
    end
    it 'displays all json objects by item_id' do
      item_1 = create(:item)
      item_2 = create(:item)

      inv_item_1 = create(:invoice_item, item_id: item_1.id)
      inv_item_2 = create(:invoice_item, item_id: item_2.id)
      inv_item_3 = create(:invoice_item, item_id: item_2.id)

      get "/api/v1/invoice_items/find_all?item_id=#{inv_item_2.item_id}"

      expect(response).to be_successful

      i_items = JSON.parse(response.body)

      expect(i_items.length).to eq(2)
      expect(i_items.first['item_id']).to eq(item_2.id)
      expect(i_items.last['item_id']).to eq(item_2.id)
    end
    it 'displays all json objects by created_at' do
      inv_item_1 = create(:invoice_item, quantity: 735, created_at: "2012-03-09 08:57:21 UTC")
      inv_item_2 = create(:invoice_item, quantity: 782, created_at: "2012-03-09 08:57:21 UTC")

      get "/api/v1/invoice_items/find_all?created_at=#{inv_item_1.created_at}"

      expect(response).to be_successful

      i_items = JSON.parse(response.body)

      expect(i_items.length).to eq(2)
      expect(i_items.first['quantity']).to eq(inv_item_1.quantity)
      expect(i_items.last['quantity']).to eq(inv_item_2.quantity)
    end
    it 'displays all json objects by updated_at' do
      inv_item_1 = create(:invoice_item, quantity: 16390, updated_at: "2012-03-09 08:57:21 UTC")
      inv_item_2 = create(:invoice_item, quantity: 19723, updated_at: "2012-03-09 08:57:21 UTC")

      get "/api/v1/invoice_items/find_all?updated_at=#{inv_item_1.updated_at}"

      expect(response).to be_successful

      inv_items = JSON.parse(response.body)

      expect(inv_items.length).to eq(2)
      expect(inv_items.first['quantity']).to eq(inv_item_1.quantity)
      expect(inv_items.last['quantity']).to eq(inv_item_2.quantity)
    end
    it 'finds and returns a random Invoice Item' do
      invoice_item1 = create(:invoice_item)
      invoice_item2 = create(:invoice_item)
      invoice_item3 = create(:invoice_item)

      get "/api/v1/invoice_items/random"

      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)

      expect(invoice_item.values.count).to eq(5)
    end
  end
end
