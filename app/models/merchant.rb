class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items

  validates :name, presence: true

  def self.order_by_name(order = 'asc')
    order = 'asc' unless order == 'desc'

    order(name: order)
  end
end
