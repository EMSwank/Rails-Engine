class Api::V1::Merchants::ItemsRelationController < ApplicationController

  def index
    render json: Merchant.find(params[:id]).items
  end
end