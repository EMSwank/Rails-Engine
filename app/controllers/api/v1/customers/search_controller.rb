class Api::V1::Customers::SearchController < ApplicationController
  
  def show
    render json: Customer.find(params[:id]) if params[:id]
  end
end