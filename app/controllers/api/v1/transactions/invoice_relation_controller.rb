class Api::V1::Transactions::InvoiceRelationController < ApplicationController

  def show
    render json: Transaction.find(params[:id]).invoice
  end
end