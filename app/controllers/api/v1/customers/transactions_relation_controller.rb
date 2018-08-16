class Api::V1::Customers::TransactionsRelationController < ApplicationController

  def index
    render json: Customer.find(params[:id]).transactions
  end
end