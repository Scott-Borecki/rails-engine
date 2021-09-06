class Api::V1::Items::FindController < ApplicationController
  def index
    if params[:name].present?
      if params[:min_price].present? || params[:max_price].present?
        bad_request
      else
        find_by_name
      end
    elsif params[:min_price].present? && params[:max_price].present?
      find_by_price_range
    elsif params[:min_price].present?
      find_by_min_price
    elsif params[:max_price].present?
      find_by_max_price
    else
      bad_request
    end
  end

  private

  def find_by_max_price
    item = Item.find_by_max_price(params[:max_price])
    return bad_request if item == 'bad request'

    formatted_item = ItemSerializer.format_item(item)
    json_response(formatted_item)
  end

  def find_by_min_price
    item = Item.find_by_min_price(params[:min_price])
    return bad_request if item == 'bad request'

    formatted_item = ItemSerializer.format_item(item)
    json_response(formatted_item)
  end

  def find_by_name
    item = Item.find_by_name(params[:name])
    formatted_item = ItemSerializer.format_item(item)
    json_response(formatted_item)
  end

  def find_by_price_range
    item = Item.find_by_price_range(params[:min_price], params[:max_price])
    return bad_request if item == 'bad request'

    formatted_item = ItemSerializer.format_item(item)
    json_response(formatted_item)
  end
end
