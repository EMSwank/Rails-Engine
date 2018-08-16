class Api::V1::Transactions::SearchController < ApplicationController

  def show
    render json: Transaction.find_by(search_params)
  end

  private

  def search_params
    params.permit(:credit_card_number, :id, :invoice_id, :result, :created_at, :updated_at)
  end
  
end