class Api::V1::Merchants::FindAllController < ApplicationController
  before_action :validate_name, only: [:index]

  def index
    merchants = Merchant.find_all_by_name(params[:name])
    formatted_merchants = MerchantSerializer.format_merchants(merchants)
    json_response(formatted_merchants)
  end

  private

  def find_params
    params.permit(:name)
  end

  def validate_name
    validator = Api::V1::Merchants::FindValidator.new(find_params)
    return if validator.valid?

    json_error_response(validator.errors, :bad_request)
  end
end
