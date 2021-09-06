class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    if params[:quantity].present? &&
       convert_to_float(params[:quantity]).positive?
    then
      merchants = Merchant.top_by_items_sold(params[:quantity])
      formatted = MerchantSerializer.format_merchants_items_sold(merchants)
      json_response(formatted)
    else
      bad_request
    end
  end
end
