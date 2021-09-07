class Api::V1::MerchantsController < ApplicationController
  include Pageable

  def index
    merchants = Merchant.all.offset(offset).limit(per_page)
    formatted_merchants = MerchantSerializer.format_merchants(merchants)
    json_response(formatted_merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    formatted_merchant = MerchantSerializer.format_merchant(merchant)
    json_response(formatted_merchant)
  end
end
