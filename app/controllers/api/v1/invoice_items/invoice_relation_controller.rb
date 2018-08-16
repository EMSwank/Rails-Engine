class Api::V1::InvoiceItems::InvoiceRelationController < ApplicationController

  def show
    render json: InvoiceItem.find(params[:id]).invoice
  end
end