class Api::V1::Items::MerchantRelationController < ApplicationController

  def show
    render json: Item.find(params[:id]).merchant
  end
end