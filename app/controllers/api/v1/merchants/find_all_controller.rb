class Api::V1::Merchants::FindAllController < ApplicationController
  def index
    if params[:name].present?
      merchants = Merchant.find_all_by_name(params[:name])
      formatted_merchants = MerchantSerializer.format_merchants(merchants)
      json_response(formatted_merchants)
    else
      bad_request
    end
  end
end
