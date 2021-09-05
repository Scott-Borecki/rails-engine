class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items

  validates :name, presence: true

  def self.order_by_name(order = 'asc')
    order = 'asc' unless order == 'desc'

    order(name: order)
  end

  def self.find_all_by_name(name = nil)
    return nil if name.nil?

    where('name ILIKE ?', "%#{name}%")
      .order_by_name
  end
end
