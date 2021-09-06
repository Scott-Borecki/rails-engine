class ItemSerializer
  def self.format_items(items)
    {
      data:
        if items.nil?
          {}
        else
          items.map do |item|
            {
              id: item.id.to_s,
              type: 'item',
              attributes: {
                name: item.name,
                description: item.description,
                unit_price: item.unit_price,
                merchant_id: item.merchant_id
              }
            }
          end
        end
    }
  end

  def self.format_item(item)
    {
      data:
        if item.nil?
          {}
        else
          {
            id: item.id.to_s,
            type: 'item',
            attributes: {
              name: item.name,
              description: item.description,
              unit_price: item.unit_price,
              merchant_id: item.merchant_id
            }
          }
        end
    }
  end
end
