class Api::V1::Items::MerchantController < ApplicationController
  before_action :validate_query, only: [:index]

  def index
    item = Item.find(params[:item_id])
    merchant = item.merchant
    formatted_merchant = MerchantSerializer.format_merchant(merchant)
    render json_response(formatted_merchant)
  end

  private

  def merchant_params
    params.permit(:item_id)
  end

  def validate_query
    validator = Api::V1::Items::MerchantValidator.new(merchant_params)
    return if validator.valid?

    render json_error_response(validator.errors, :not_found)
  end
end
