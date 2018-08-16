class Api::V1::Invoices::ItemsRelationController < ApplicationController
  
  def index
    render json: Invoice.find(params[:id]).items
  end
end