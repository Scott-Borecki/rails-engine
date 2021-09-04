class Api::V1::Items::MerchantController < ApplicationController
  def index
    item = Item.find(params[:item_id])
    merchant = item.merchant
    formatted_merchant = MerchantSerializer.format_merchant(merchant)
    json_response(formatted_merchant)
  end
end
