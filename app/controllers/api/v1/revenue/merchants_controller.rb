class Api::V1::Revenue::MerchantsController < ApplicationController
  before_action :validate_query, only: [:index]

  def index
    merchants = Merchant.top_by_revenue(params[:quantity])
    formatted = RevenueSerializer.format_merchants(merchants)
    json_response(formatted)
  end

  def show
    merchant = Merchant.find(params[:id])
    formatted_revenue = RevenueSerializer.format_merchant(merchant)
    json_response(formatted_revenue)
  end

  private

  def merchants_params
    params.permit(:quantity)
  end

  def validate_query
    validator = Api::V1::Revenue::MerchantsValidator.new(merchants_params)
    return if validator.valid?

    json_error_response(validator.errors, :bad_request)
  end
end
