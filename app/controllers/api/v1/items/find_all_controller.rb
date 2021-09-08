class Api::V1::Items::FindAllController < ApplicationController
  before_action :validate_query, only: [:index]

  def index
    if params[:name].present?
      find_all_by_name
    elsif params[:min_price].present? && params[:max_price].present?
      find_all_by_price_range
    elsif params[:min_price].present?
      find_all_by_min_price
    elsif params[:max_price].present?
      find_all_by_max_price
    end
  end

  private

  def find_params
    params.permit(:name, :min_price, :max_price)
  end

  def validate_query
    validator = Api::V1::Items::FindValidator.new(find_params)
    return if validator.valid?

    json_error_response(validator.errors, :bad_request)
  end

  def find_all_by_max_price
    items = Item.find_all_by_max_price(params[:max_price])
    return bad_request if items == 'bad request'

    formatted_items = ItemSerializer.format_items(items)
    json_response(formatted_items)
  end

  def find_all_by_min_price
    items = Item.find_all_by_min_price(params[:min_price])
    return bad_request if items == 'bad request'

    formatted_items = ItemSerializer.format_items(items)
    json_response(formatted_items)
  end

  def find_all_by_name
    items = Item.find_all_by_name(params[:name])
    formatted_items = ItemSerializer.format_items(items)
    json_response(formatted_items)
  end

  def find_all_by_price_range
    items = Item.find_all_by_price_range(params[:min_price], params[:max_price])
    return bad_request if items == 'bad request'

    formatted_items = ItemSerializer.format_items(items)
    json_response(formatted_items)
  end
end
