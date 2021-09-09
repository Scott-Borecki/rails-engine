class Api::V1::ItemsController < ApplicationController
  include Pageable

  def index
    items = Item.all.offset(offset).limit(per_page)
    formatted_items = ItemSerializer.format_items(items)
    render json_response(formatted_items)
  end

  def show
    item = Item.find(params[:id])
    formatted_item = ItemSerializer.format_item(item)
    render json_response(formatted_item)
  end

  def create
    item = Item.create!(item_params)
    formatted_item = ItemSerializer.format_item(item)
    render json_response(formatted_item, :created)
  end

  def update
    item = Item.find(params[:id])
    Merchant.find(params[:merchant_id]) if params[:merchant_id]
    item.update!(item_params)
    formatted_item = ItemSerializer.format_item(item)
    render json_response(formatted_item)
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
