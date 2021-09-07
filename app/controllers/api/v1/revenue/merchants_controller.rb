class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity].present? &&
       convert_to_float(params[:quantity]).positive?
    then
      merchants = Merchant.top_by_revenue(params[:quantity])
      formatted = RevenueSerializer.format_merchants(merchants)
      json_response(formatted)
    else
      bad_request
    end
  end

  def show
    merchant = Merchant.find(params[:id])
    formatted_revenue = RevenueSerializer.format_merchant(merchant)
    json_response(formatted_revenue)
  end
end
