class Api::V1::Invoices::SearchController < ApplicationController
  def show
    render json: Invoice.find(params[:id]) if params[:id]
    render json: Invoice.find_by_customer_id(params[:customer_id]) if params[:customer_id]
    render json: Invoice.find_by_merchant_id(params[:merchant_id]) if params[:merchant_id]
    render json: Invoice.find_by_status(params[:status]) if params[:status]
    render json: Invoice.find_by_created_at(params[:created_at]) if params[:created_at]
    render json: Invoice.find_by_updated_at(params[:updated_at]) if params[:updated_at]
  end

  def index
    render json: Invoice.where('id=?', params[:id]) if params[:id]
    render json: Invoice.where('customer_id=?', params[:customer_id]) if params[:customer_id]
    render json: Invoice.where('merchant_id=?', params[:merchant_id]) if params[:merchant_id]
    render json: Invoice.where('status=?', params[:status]) if params[:status]
    render json: Invoice.where('created_at=?', params[:created_at]) if params[:created_at]
    render json: Invoice.where('updated_at=?', params[:updated_at]) if params[:updated_at]
  end
end
