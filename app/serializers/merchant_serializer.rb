class MerchantSerializer
  def self.format_merchants(merchants)
    {
      'data':
        merchants.map do |merchant|
          {
            'id': merchant.id.to_s,
            'type': merchant.class.name.demodulize.downcase,
            'attributes': {
              'name': merchant.name
            }
          }
        end
    }
  end
end
