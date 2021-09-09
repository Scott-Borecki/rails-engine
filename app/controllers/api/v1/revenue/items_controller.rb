class Api::V1::Revenue::ItemsController < ApplicationController
  before_action :validate_query, only: [:index]

  def index
    items = if params[:quantity].present?
              Item.top_by_revenue(params[:quantity])
            else
              Item.top_by_revenue
            end
    formatted_items = RevenueSerializer.format_items(items)
    render json_response(formatted_items)
  end

  private

  def items_params
    params.permit(:quantity)
  end

  def validate_query
    return unless params[:quantity]

    validator = Api::V1::Revenue::ItemsValidator.new(items_params)
    return if validator.valid?

    render json_error_response(validator.errors, :bad_request)
  end
end
