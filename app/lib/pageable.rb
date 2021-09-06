# The 'Pageable' module provides pagination capabilities for collections in a
# controller. The page and per_page params are evaluated to determine the
# offset.  The collection can be paginated by including the 'Pageable' module
# and appending the collection with: `.offset(offset).limit(per_page)`
#
# Here's an example for the 'index' action of the Api::V1::MerchantsController:
#
# class Api::V1::MerchantsController < ApplicationController
#   include Pageable
#
#   def index
#     merchants = Merchant.all.offset(offset).limit(per_page)
#     # ...
#   end
# end
#
module Pageable
  def page
    params.fetch(:page, 1).to_i
  end

  def per_page
    params.fetch(:per_page, 20).to_i
  end

  def offset
    page <= 1 ? 0 : (page - 1) * per_page
  end
end
