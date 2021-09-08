module Api
  module V1
    module Merchants
      class MostItemsValidator
        include ActiveModel::Validations

        attr_accessor :quantity

        validates :quantity, presence: true,
                             numericality: { allow_nil: true, greater_than: 0 }

        def initialize(data = {})
          @quantity = data[:quantity]
        end
      end
    end
  end
end
