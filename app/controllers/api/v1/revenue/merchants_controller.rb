class Api::V1::Revenue::MerchantsController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    formatted_revenue = RevenueSerializer.format_merchant_revenue(merchant)
    json_response(formatted_revenue)
  end
end
