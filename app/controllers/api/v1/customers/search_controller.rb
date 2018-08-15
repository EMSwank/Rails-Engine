class Api::V1::Customers::SearchController < ApplicationController
  
  def show
    render json: Customer.find(params[:id]) if params[:id]
    render json: Customer.find_by_first_name(params[:first_name]) if params[:first_name]
  end
end