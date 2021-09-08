class Api::V1::Merchants::MostItemsController < ApplicationController
  before_action :validate_query, only: [:index]

  def index
    merchants = Merchant.top_by_items_sold(params[:quantity])
    formatted = MerchantSerializer.format_merchants_items_sold(merchants)
    json_response(formatted)
  end

  private

  def most_items_params
    params.permit(:quantity)
  end

  def validate_query
    validator = Api::V1::Merchants::MostItemsValidator.new(most_items_params)
    return if validator.valid?

    json_error_response(validator.errors, :bad_request)
  end
end
