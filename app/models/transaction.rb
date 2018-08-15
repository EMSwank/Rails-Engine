class Transaction < ApplicationRecord
  validates_presence_of :invoice_id,
                        :credit_card_number,
                        :result
  
  # scope :success, -> { where(result: 'success') }

  # default_scope -> { order(:id, :asc) }
end
