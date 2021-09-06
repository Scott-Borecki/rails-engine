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

  def self.format_merchants_revenue(merchants)
    {
      data:
        merchants.map do |merchant|
          {
            id: merchant.id.to_s,
            type: 'merchant_name_revenue',
            attributes: {
              name: merchant.name,
              revenue: merchant.total_revenue
            }
          }
        end
    }
  end
end
