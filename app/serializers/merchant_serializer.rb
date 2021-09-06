class MerchantSerializer
  def self.format_merchant(merchant)
    {
      data:
      {
        id: merchant.id.to_s,
        type: 'merchant',
        attributes: {
          name: merchant.name
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
            type: 'merchant',
            attributes: {
              name: merchant.name
            }
          }
        end
    }
  end

  def self.format_merchants_items_sold(merchants)
    {
      data:
        merchants.map do |merchant|
          {
            id: merchant.id.to_s,
            type: 'items_sold',
            attributes: {
              name: merchant.name,
              count: merchant.total_sold
            }
          }
        end
    }
  end
end
