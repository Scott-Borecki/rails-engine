class RevenueSerializer
  def self.format_items(items)
    {
      data:
        items.map do |item|
          {
            id: item.id.to_s,
            type: 'item_revenue',
            attributes: {
              name: item.name,
              description: item.description,
              unit_price: item.unit_price,
              merchant_id: item.merchant_id,
              revenue: item.total_revenue
            }
          }
        end
    }
  end

  def self.format_merchant(merchant)
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

  def self.format_merchants(merchants)
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
