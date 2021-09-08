module Api
  module V1
    module Items
      class FindValidator
        include ActiveModel::Validations

        attr_accessor :max_price, :min_price, :name

        validate :query_must_be_provided
        validate :name_cannot_be_queried_with_prices
        validate :max_price_must_be_greater_than_min_price
        validates :max_price, numericality: { allow_nil: true, greater_than: 0 }
        validates :min_price, numericality: { allow_nil: true, greater_than: 0 }

        def initialize(data = {})
          @max_price = data[:max_price]
          @min_price = data[:min_price]
          @name      = data[:name]
        end

        def query_must_be_provided
          return unless name.blank? && max_price.blank? && min_price.blank?

          errors.add(:query, 'query must be provided with a value')
        end

        def max_price_must_be_greater_than_min_price
          if max_price.present? &&
             min_price.present? &&
             max_price.to_i < min_price.to_i
          then
            errors.add(:price, 'max price must be greater than min price')
          end
        end

        def name_cannot_be_queried_with_prices
          if name.present? &&
             (max_price.present? || min_price.present?)
          then
            errors.add(:name, 'cannot be queried with price')
          end
        end
      end
    end
  end
end
