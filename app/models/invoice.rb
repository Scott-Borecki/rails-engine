class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy

  validates :status, presence: true,
                     inclusion: { in: %w[shipped packaged returned] }

  def self.considered_as_revenue
    joins(:transactions)
      .where(invoices: { status: 'shipped' },
             transactions: { result: 'success' })
  end

  def self.total_revenue_generated
    considered_as_revenue
      .joins(:invoice_items)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
