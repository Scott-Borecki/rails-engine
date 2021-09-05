class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  def self.order_by_name(order = 'asc')
    order = 'asc' unless order == 'desc'

    order(name: order)
  end

  def self.find_by_max_price(price = nil)
    price = convert_to_float(price)
    return nil if price.nil?
    return 'bad request' if price < 0

    order_by_name
      .find_by('unit_price <= ?', price)
  end

  def self.find_by_min_price(price = nil)
    price = convert_to_float(price)
    return nil if price.nil?
    return 'bad request' if price < 0

    order_by_name
      .find_by('unit_price >= ?', price)
  end

  def self.find_by_price_range(min = nil, max = nil)
    min = convert_to_float(min)
    max = convert_to_float(max)
    return nil if min.nil? || max.nil?
    return 'bad request' if min > max || min < 0 || max < 0

    order_by_name
      .find_by('unit_price >= ? and unit_price <= ?', min, max)
  end

  def self.find_by_name(name = nil)
    return nil if name.nil?

    order_by_name
      .find_by('name ILIKE ?', "%#{name}%")
  end
end
