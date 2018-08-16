class Api::V1::Items::InvoiceItemsRelationController < ApplicationController

  def index
    render json: Item.find(params[:id]).invoice_items
  end
end