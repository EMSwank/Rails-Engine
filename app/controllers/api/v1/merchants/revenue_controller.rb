class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    if !params[:date]
      revenue = Merchant.find(params[:id]).successful_transactions_total
      render json: {"revenue" => (revenue * 0.01).round(2).to_s}
    else
      date = Date.parse("#{params[:date]} 00.00.00. UTC")
      revenue = Merchant.find(params[:id]).revenue_by_date(date)
      render json: {"revenue" => (revenue * 0.01).round(2).to_s}
    end
  end

  def index
    date = Date.parse("#{params[:date]} 00.00.00. UTC")
    revenue = Merchant.total_revenue_for_date(date)
    render json: {"total_revenue" => (revenue * 0.01).round(2).to_s}
  end
end
