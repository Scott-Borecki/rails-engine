class MerchantSerializer
  # TODO: Consider adding a 'no results' message for nil?
  #       Would need to confirm that nil is only returned when it is empty.
  def self.format_merchant(merchant)
    {
      data:
      if merchant.nil?
        {}
      else
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

  def self.format_merchants(merchants)
    {
      data:
        if merchants.nil?
          {}
        else
          merchants.map do |merchant|
            {
              id: merchant.id.to_s,
              type: 'merchant',
              attributes: {
                name: merchant.name
              }
            }
          end
        end
    }
  end

  def self.format_merchants_items_sold(merchants)
    {
      data:
        if merchants.nil?
          {}
        else
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
        end
    }
  end
end
