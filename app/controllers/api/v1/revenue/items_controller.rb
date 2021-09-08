class Api::V1::Revenue::ItemsController < ApplicationController
  before_action :validate_query, only: [:index]

  def index
    items = if !params[:quantity]
              Item.top_by_revenue
            else
              Item.top_by_revenue(params[:quantity])
            end
    formatted_items = RevenueSerializer.format_items(items)
    json_response(formatted_items)
  end

  private

  def items_params
    params.permit(:quantity)
  end

  def validate_query
    return if !params[:quantity]
    validator = Api::V1::Revenue::ItemsValidator.new(items_params)
    return if validator.valid?

    json_error_response(validator.errors, :bad_request)
  end
end
