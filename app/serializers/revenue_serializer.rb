class RevenueSerializer
  def self.format_merchant_revenue(merchant)
    {
      data:
        {
          id: merchant.id.to_s,
          type: 'merchant_revenue',
          attributes: {
            revenue: merchant.total_revenue_generated
          }
        }
    }
  end
end
