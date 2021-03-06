class Api::V1::Merchants::FindController < ApplicationController
  before_action :validate_query, only: [:index]

  def index
    merchant = Merchant.find_by_name(params[:name])
    formatted_merchant = MerchantSerializer.format_merchant(merchant)
    render json_response(formatted_merchant)
  end

  private

  def find_params
    params.permit(:name)
  end

  def validate_query
    validator = Api::V1::Merchants::FindValidator.new(find_params)
    return if validator.valid?

    render json_error_response(validator.errors, :bad_request)
  end
end
