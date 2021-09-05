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
    price =
      begin
        Float(price)
      rescue ArgumentError
        nil
      end

    order_by_name
      .find_by('unit_price <= ?', price)
  end

  def self.find_by_min_price(price = nil)
    price =
      begin
        Float(price)
      rescue ArgumentError
        nil
      end

    order_by_name
      .find_by('unit_price >= ?', price)
  end

  def self.find_by_name(name = nil)
    return nil if name.nil?

    order_by_name
      .find_by('name ILIKE ?', "%#{name}%")
  end
end
