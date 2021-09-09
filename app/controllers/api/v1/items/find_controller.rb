class Api::V1::Items::FindController < ApplicationController
  before_action :validate_query, only: [:index]

  def index
    if params[:name].present?
      find_by_name
    elsif params[:min_price].present? && params[:max_price].present?
      find_by_price_range
    elsif params[:min_price].present?
      find_by_min_price
    elsif params[:max_price].present?
      find_by_max_price
    end
  end

  private

  def find_params
    params.permit(:name, :min_price, :max_price)
  end

  def validate_query
    validator = Api::V1::Items::FindValidator.new(find_params)
    return if validator.valid?

    render json_error_response(validator.errors, :bad_request)
  end

  def find_by_max_price
    item = Item.find_by_max_price(params[:max_price])
    return bad_request if item == 'bad request'

    formatted_item = ItemSerializer.format_item(item)
    render json_response(formatted_item)
  end

  def find_by_min_price
    item = Item.find_by_min_price(params[:min_price])
    return bad_request if item == 'bad request'

    formatted_item = ItemSerializer.format_item(item)
    render json_response(formatted_item)
  end

  def find_by_name
    item = Item.find_by_name(params[:name])
    formatted_item = ItemSerializer.format_item(item)
    render json_response(formatted_item)
  end

  def find_by_price_range
    item = Item.find_by_price_range(params[:min_price], params[:max_price])
    return bad_request if item == 'bad request'

    formatted_item = ItemSerializer.format_item(item)
    render json_response(formatted_item)
  end
end
