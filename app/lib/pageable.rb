# Public: Various methods for paginating collections in a controller.
#
# page     - The page of the collection (default: 1).
# per_page - The number of results per page (default: 20).
# offset   - Determines which results to display based on the page and per_page
#            parameters.
#
# The collection can be paginated by including the 'Pageable' module and
# appending the collection with:
#
#   `.offset(offset).limit(per_page)`
#
# Examples
#
#   class Merchant < ApplicationRecord
#     # ...
#   end
#
#   class Api::V1::MerchantsController < ApplicationController
#     include Pageable
#
#     def index
#       merchants = Merchant.all.offset(offset).limit(per_page)
#       # ...
#     end
#   end
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
