FactoryBot.define do
  factory :transaction do
    invoice_id 1
    credit_card_number Faker::Business.credit_card_number
    credit_card_expiration_date Faker::Business.credit_card_expiry_date
    result "success"
  end
end
