class Merchant < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items

  delegate :total_revenue_generated, to: :invoices

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

  def self.top_by_items_sold(quantity = 5)
    joins(invoices: :invoice_items)
      .merge(Invoice.considered_as_revenue)
      .select('merchants.*,
               SUM(invoice_items.quantity) AS total_sold')
      .group(:id)
      .order(total_sold: :desc)
      .limit(quantity)
  end

  def self.top_by_revenue(quantity)
    joins(invoices: :invoice_items)
      .merge(Invoice.considered_as_revenue)
      .select('merchants.*,
               SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
      .group(:id)
      .order(total_revenue: :desc)
      .limit(quantity)
  end
end
