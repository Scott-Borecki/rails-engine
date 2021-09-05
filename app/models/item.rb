class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  def self.order_by_name(order = 'asc')
    order == 'desc' ? order = 'desc' : order = 'asc'
    order(name: order)
  end

  def self.find_by_name(name = nil)
    return nil if name.nil?

    order_by_name
      .find_by('name ILIKE ?', "%#{name}%")
  end
end
