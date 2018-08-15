class Api::V1::Customers::SearchController < ApplicationController
  
  def show
    render json: Customer.find(params[:id]) if params[:id]
    render json: Customer.find_by_first_name(params[:first_name]) if params[:first_name]
    render json: Customer.find_by_last_name(params[:last_name]) if params[:last_name]
    render json: Customer.find_by_created_at(params[:created_at]) if params[:created_at]
    render json: Customer.find_by_updated_at(params[:updated_at]) if params[:updated_at]
  end

  def index
    render json: Customer.where("id=?", params[:id]) if params[:id]
  end
end