class Api::V1::MerchantsController < ApplicationController
  # TODO: Refactor action by abstracting page, per_page, and offset to module?
  #       Will likely be able to reuse for other controllers/actions
  def index
    page = params.fetch(:page, 1).to_i
    per_page = params.fetch(:per_page, 20).to_i
    offset = page <= 1 ? 0 : (page - 1) * per_page
    merchants = Merchant.all.offset(offset).limit(per_page)
    render json: MerchantSerializer.format_merchants(merchants)
  end
end
