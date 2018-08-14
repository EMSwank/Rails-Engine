class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: Merchant.find(params[:id]) if params[:id]
  end
end