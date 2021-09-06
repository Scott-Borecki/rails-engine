class Api::V1::Revenue::ItemsController < ApplicationController
  def index
    if !params[:quantity]
      items = Item.top_by_revenue
      formatted_items = RevenueSerializer.format_items_revenue(items)
      json_response(formatted_items)
    elsif !params[:quantity].blank? &&
          !convert_to_float(params[:quantity]).nil? &&
          convert_to_float(params[:quantity]).positive?
    then
      items = Item.top_by_revenue(params[:quantity])
      formatted_items = RevenueSerializer.format_items_revenue(items)
      json_response(formatted_items)
    else
      bad_request
    end
  end
end
