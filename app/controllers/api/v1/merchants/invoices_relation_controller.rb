class Api::V1::Merchants::InvoicesRelationController < ApplicationController

  def index
    render json: Merchant.find(params[:id]).invoices
  end
end