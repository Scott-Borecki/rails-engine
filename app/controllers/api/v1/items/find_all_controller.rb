class Api::V1::Items::FindAllController < ApplicationController
  def index
    if params[:name].present?
      if params[:min_price].present? || params[:max_price].present?
        bad_request
      else
        find_all_by_name
      end
    elsif params[:min_price].present? && params[:max_price].present?
      find_all_by_price_range
    elsif params[:min_price].present?
      find_all_by_min_price
    elsif params[:max_price].present?
      find_all_by_max_price
    else
      bad_request
    end
  end

  private

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
