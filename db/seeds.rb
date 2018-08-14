require 'csv'

CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |merchant|
  Merchant.create(id: merchant[:id],
                 name: merchant[:name],
                 created_at: merchant[:created_at],
                 updated_at: merchant[:updated_at])
end
