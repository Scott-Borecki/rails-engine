class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    if params[:quantity].present? && convert_to_float(params[:quantity]).positive?
      merchants = Merchant.top_by_items_sold(params[:quantity])
      formatted_merchants = MerchantSerializer.format_merchants_items_sold(merchants)
      json_response(formatted_merchants)
    else
      bad_request
    end
  end
end
