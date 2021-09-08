module Api
  module V1
    module Items
      class MerchantValidator
        include ActiveModel::Validations

        attr_accessor :item_id

        validates :item_id, numericality: true

        def initialize(data = {})
          @item_id = data[:item_id]
        end
      end
    end
  end
end
