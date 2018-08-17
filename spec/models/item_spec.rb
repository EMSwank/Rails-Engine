require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices).through(:invoice_items) }
  it { should belong_to(:merchant) }

  describe 'class methods' do
    it 'returns the top items ranked by revenue' do
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)

      invoice1 = create(:invoice)
      invoice2 = create(:invoice)

      invoice_item = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, unit_price: 80, quantity: 4)
      invoice_item = create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, unit_price: 40, quantity: 20)
      invoice_item = create(:invoice_item, invoice_id: invoice1.id, item_id: item3.id, unit_price: 80, quantity: 2)

      transaction1 = create(:transaction, invoice_id: invoice1.id, result: 'success')
      transaction2 = create(:transaction, invoice_id: invoice2.id, result: 'success')

      expect(Item.most_revenue(3)).to eq([item2, item1, item3])
    end
    it 'returns the top items ranked by number sold' do
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)

      invoice1 = create(:invoice)
      invoice2 = create(:invoice)

      invoice_item = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, unit_price: 80, quantity: 4)
      invoice_item = create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, unit_price: 40, quantity: 20)
      invoice_item = create(:invoice_item, invoice_id: invoice1.id, item_id: item3.id, unit_price: 80, quantity: 2)

      transaction1 = create(:transaction, invoice_id: invoice1.id, result: 'success')
      transaction2 = create(:transaction, invoice_id: invoice2.id, result: 'success')

      expect(Item.most_sold(3)).to eq([item2, item1, item3])
    end
  end
end
