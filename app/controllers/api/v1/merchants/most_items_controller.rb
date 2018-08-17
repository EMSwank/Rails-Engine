class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    render json: Merchant.most_items_sold(params[:quantity])
  end
end
