class Api::V1::InvoiceItems::ItemRelationController < ApplicationController

  def show
    render json: InvoiceItem.find(params[:id]).item
  end
end