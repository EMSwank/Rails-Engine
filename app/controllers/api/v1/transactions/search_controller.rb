class Api::V1::Transactions::SearchController < ApplicationController

  def show
    render json: Transaction.find_by(search_params)
  end

  private

  def search_params
    params.permit(:crediot_card_number, :id, :invoice_id, :result)
  end
  
end