class Api::V1::Invoices::TransactionsRelationController < ApplicationController

  def index
    render json: Invoice.find(params[:id]).transactions
  end
end