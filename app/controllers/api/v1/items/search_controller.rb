class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: Item.find(params[:id]) if params[:id]
    render json: Item.find_by_name(params[:name]) if params[:name]
    render json: Item.find_by_description(params[:description]) if params[:description]
    render json: Item.find_by_unit_price(params[:unit_price]) if params[:unit_price]
    render json: Item.find_by_merchant_id(params[:merchant_id]) if params[:merchant_id]
    render json: Item.find_by_created_at(params[:created_at]) if params[:created_at]
    render json: Item.find_by_updated_at(params[:updated_at]) if params[:updated_at]
  end

  def index
    render json: Item.where('id=?', params[:id]) if params[:id]
    render json: Item.where('name=?', params[:name]) if params[:name]
    render json: Item.where('description=?', params[:description]) if params[:description]
    render json: Item.where('merchant_id=?', params[:merchant_id]) if params[:merchant_id]
    render json: Item.where('unit_price=?', params[:unit_price]) if params[:unit_price]
    render json: Item.where('created_at=?', params[:created_at]) if params[:created_at]
    render json: Item.where('updated_at=?', params[:updated_at]) if params[:updated_at]
  end
end
