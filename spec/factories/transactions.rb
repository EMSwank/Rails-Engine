FactoryBot.define do
  factory :transaction do
    invoice_id 1
    credit_card_number Faker::Business.credit_card_number
    result "success"
  end
end
