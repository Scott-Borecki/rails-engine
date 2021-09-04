class Api::V1::ItemsController < ApplicationController
  # TODO: Refactor action by abstracting page, per_page, and offset to module?
  #       Will likely be able to reuse for other controllers/actions
  def index
    page = params.fetch(:page, 1).to_i
    per_page = params.fetch(:per_page, 20).to_i
    offset = page <= 1 ? 0 : (page - 1) * per_page
    items = Item.all.offset(offset).limit(per_page)
    formatted_items = ItemSerializer.format_items(items)
    json_response(formatted_items)
  end

  def show
    item = Item.find(params[:id])
    formatted_item = ItemSerializer.format_item(item)
    json_response(formatted_item)
  end
end
