class Api::V1::Invoices::CustomerRelationController < ApplicationController
  def show
    render json: Invoice.find(params[:id]).customer
  end

end
