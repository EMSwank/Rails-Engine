class Api::V1::Invoices::SearchController < ApplicationController
  def show
    render json: Invoice.find(params[:id]) if params[:id]
    render json: Invoice.find_by_customer_id(params[:customer_id]) if params[:customer_id]
    render json: Invoice.find_by_merchant_id(params[:merchant_id]) if params[:merchant_id]
  end
end
