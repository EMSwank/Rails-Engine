class Api::V1::Invoices::MerchantRelationController < ApplicationController
  def show
    render json: Invoice.find(params[:id]).merchant
  end
end
