class Api::V1::Items::FindController < ApplicationController
  def index
    if params[:name].present?
      if params[:min_price].present? || params[:max_price].present?
        json_response({ error: nil }, :bad_request)
      else
        item = Item.find_by_name(params[:name])
        formatted_item = ItemSerializer.format_item(item)
        json_response(formatted_item)
      end
    elsif params[:min_price].present? && params[:max_price].present?
      item = Item.find_by_price_range(params[:min_price], params[:max_price])
      return json_response({ error: nil }, :bad_request) if item == 'bad request'

      formatted_item = ItemSerializer.format_item(item)
      json_response(formatted_item)
    elsif params[:min_price].present?
      item = Item.find_by_min_price(params[:min_price])
      return json_response({ error: nil }, :bad_request) if item == 'bad request'

      formatted_item = ItemSerializer.format_item(item)
      json_response(formatted_item)
    elsif params[:max_price].present?
      item = Item.find_by_max_price(params[:max_price])
      return json_response({ error: nil }, :bad_request) if item == 'bad request'

      formatted_item = ItemSerializer.format_item(item)
      json_response(formatted_item)
    else
      json_response({ error: nil }, :bad_request)
    end
  end
end
