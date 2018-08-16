class Api::V1::Customers::InvoicesRelationController < ApplicationController

  def index
    render json: Customer.find(params[:id]).invoices
  end
end