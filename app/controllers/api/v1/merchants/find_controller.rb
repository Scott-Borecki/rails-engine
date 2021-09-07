class Api::V1::Merchants::FindController < ApplicationController
  def index
    if params[:name].present?
      merchant = Merchant.find_by_name(params[:name])
      formatted_merchant = MerchantSerializer.format_merchant(merchant)
      json_response(formatted_merchant)
    else
      bad_request
    end
  end
end
