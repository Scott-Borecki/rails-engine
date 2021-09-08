class Api::V1::Merchants::ItemsController < ApplicationController
  before_action :validate_query, only: [:index]

  def index
    merchant = Merchant.find(params[:merchant_id])
    items = merchant.items
    formatted_items = ItemSerializer.format_items(items)
    json_response(formatted_items)
  end

  private

  def item_params
    params.permit(:merchant_id)
  end

  def validate_query
    validator = Api::V1::Merchants::ItemsValidator.new(item_params)
    return if validator.valid?

    json_error_response(validator.errors, :not_found)
  end
end
