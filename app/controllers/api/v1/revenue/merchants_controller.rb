class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity].present? && convert_to_float(params[:quantity]).positive?
      merchants = Merchant.top_by_revenue(params[:quantity])
      formatted_merchants = RevenueSerializer.format_merchants_revenue(merchants)
      json_response(formatted_merchants)
    else
      bad_request
    end
  end

  def show
    merchant = Merchant.find(params[:id])
    formatted_revenue = RevenueSerializer.format_merchant_revenue(merchant)
    json_response(formatted_revenue)
  end
end
