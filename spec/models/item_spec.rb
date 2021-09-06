require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items).dependent(:destroy) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }

    it 'is valid with valid attributes' do
      item = create(:item)
      expect(item).to be_valid
    end
  end

  describe 'class methods' do
    describe '.convert_to_float' do
      context 'when I provide a float string' do
        it 'returns a float' do
          expect(Item.convert_to_float('5.25')).to be_a Float
          expect(Item.convert_to_float('5.25')).to eq(5.25)
        end
      end

      context 'when I provide a float' do
        it 'returns a float' do
          expect(Item.convert_to_float(5.25)).to be_a Float
          expect(Item.convert_to_float(5.25)).to eq(5.25)
        end
      end

      context 'when I provide an integer string' do
        it 'returns a float' do
          expect(Item.convert_to_float('5')).to be_a Float
          expect(Item.convert_to_float('5')).to eq(5.0)
        end
      end

      context 'when I provide an integer' do
        it 'returns a float' do
          expect(Item.convert_to_float(5)).to be_a Float
          expect(Item.convert_to_float(5)).to eq(5.0)
        end
      end

      context 'when I provide a non-numeric string' do
        it 'returns nil' do
          expect(Item.convert_to_float('one')).to be_nil
          expect(Item.convert_to_float('one1')).to be_nil
          expect(Item.convert_to_float('1one')).to be_nil
        end
      end
    end

    describe '.order_by_name' do
      let!(:item1) { create(:item, name: 'BaA') } # Asc Order: 2
      let!(:item2) { create(:item, name: 'baa') } # Asc Order: 5
      let!(:item3) { create(:item, name: 'bAA') } # Asc Order: 4
      let!(:item4) { create(:item, name: 'Baa') } # Asc Order: 3
      let!(:item5) { create(:item, name: 'BAa') } # Asc Order: 1
      let(:asc) { [item5, item1, item4, item3, item2] }
      let(:desc) { [item2, item3, item4, item1, item5] }

      context 'when I do not provide any parameters' do
        it 'orders the items by name (case-sensitive) in ascending order (default)' do
          expect(Item.order_by_name).to eq(asc)
        end
      end

      context 'when I provide a parameter "desc"' do
        it 'orders the items by name (case-sensitive) in descending order' do
          expect(Item.order_by_name('desc')).to eq(desc)
        end
      end

      context 'when I provide a parameter other than "desc"' do
        it 'orders the items by name (case-sensitive) in ascending order (default)' do
          expect(Item.order_by_name(123)).to eq(asc)
          expect(Item.order_by_name('des')).to eq(asc)
        end
      end
    end

    describe '.find_by_max_price' do
      let!(:item1) { create(:item, name: 'BaA', unit_price: 5.25) } # Name Asc: 2; Price Desc: 5
      let!(:item2) { create(:item, name: 'baa', unit_price: 7.53) } # Name Asc: 5; Price Desc: 3
      let!(:item3) { create(:item, name: 'bAA', unit_price: 9.41) } # Name Asc: 4; Price Desc: 1
      let!(:item4) { create(:item, name: 'Baa', unit_price: 8.32) } # Name Asc: 3; Price Desc: 2
      let!(:item5) { create(:item, name: 'BAa', unit_price: 6.14) } # Name Asc: 1; Price Desc: 4

      context 'when I provide a valid maximum price' do
        context 'when there are items with a unit price less than the maximum price' do
          it 'returns the item from the results by case-sensitive alphabetical order' do
            # It accepts a float price
            expect(Item.find_by_max_price(7.24)).to eq(item5)

            # It accepts a string float price
            expect(Item.find_by_max_price('7.24')).to eq(item5)

            # It accepts an integer price
            expect(Item.find_by_max_price(6)).to eq(item1)

            # It accepts a string integer price
            expect(Item.find_by_max_price('6')).to eq(item1)

            # It evaluates the price as less than or equal to
            expect(Item.find_by_max_price(5.25)).to eq(item1)
          end
        end

        context 'when there are no items with a unit price less than the maximum price' do
          it 'returns nil' do
            expect(Item.find_by_max_price(1)).to eq(nil)
          end
        end
      end

      context 'when I provide an invalid maximum price' do
        it 'returns nil' do
          expect(Item.find_by_max_price('ten')).to eq(nil)
          expect(Item.find_by_max_price('ten10')).to eq(nil)
          expect(Item.find_by_max_price('10ten')).to eq(nil)
        end
      end

      context 'when I provide a negative maximum price' do
        it 'returns "bad request"' do
          expect(Item.find_by_max_price(-10)).to eq('bad request')
        end
      end
    end

    describe '.find_by_min_price' do
      let!(:item1) { create(:item, name: 'BaA', unit_price: 5.25) } # Name Asc: 2; Price Desc: 5
      let!(:item2) { create(:item, name: 'baa', unit_price: 7.53) } # Name Asc: 5; Price Desc: 3
      let!(:item3) { create(:item, name: 'bAA', unit_price: 9.41) } # Name Asc: 4; Price Desc: 1
      let!(:item4) { create(:item, name: 'Baa', unit_price: 8.32) } # Name Asc: 3; Price Desc: 2
      let!(:item5) { create(:item, name: 'BAa', unit_price: 6.14) } # Name Asc: 1; Price Desc: 4

      context 'when I provide a valid minimum price' do
        context 'when there are items with a unit price more than the minimum price' do
          it 'returns the item from the results by case-sensitive alphabetical order' do
            # It accepts a float price
            expect(Item.find_by_min_price(7.24)).to eq(item4)

            # It accepts a string float price
            expect(Item.find_by_min_price('7.24')).to eq(item4)

            # It accepts an integer price
            expect(Item.find_by_min_price(3)).to eq(item5)

            # It accepts a string integer price
            expect(Item.find_by_min_price('3')).to eq(item5)

            # It evaluates the price as greater than or equal to
            expect(Item.find_by_min_price(8.32)).to eq(item4)
          end
        end

        context 'when there are no items with a unit price more than the minimum price' do
          it 'returns nil' do
            expect(Item.find_by_min_price(10)).to eq(nil)
          end
        end
      end

      context 'when I provide an invalid minimum price' do
        it 'returns nil' do
          expect(Item.find_by_min_price('one')).to eq(nil)
          expect(Item.find_by_min_price('one1')).to eq(nil)
          expect(Item.find_by_min_price('1one')).to eq(nil)
        end
      end

      context 'when I provide a negative minimum price' do
        it 'returns "bad request"' do
          expect(Item.find_by_min_price(-10)).to eq('bad request')
        end
      end
    end

    describe '.find_by_price_range' do
      let!(:item1) { create(:item, name: 'BaA', unit_price: 5.25) } # Name Asc: 2; Price Desc: 5
      let!(:item2) { create(:item, name: 'baa', unit_price: 7.53) } # Name Asc: 5; Price Desc: 3
      let!(:item3) { create(:item, name: 'bAA', unit_price: 9.41) } # Name Asc: 4; Price Desc: 1
      let!(:item4) { create(:item, name: 'Baa', unit_price: 8.32) } # Name Asc: 3; Price Desc: 2
      let!(:item5) { create(:item, name: 'BAa', unit_price: 6.14) } # Name Asc: 1; Price Desc: 4

      context 'when I provide a valid price range' do
        context 'when there are items within the price range' do
          it 'returns the item from the results by case-sensitive alphabetical order' do
            # It accepts a float price
            expect(Item.find_by_price_range(7.24, 9.99)).to eq(item4)

            # It accepts a string float price
            expect(Item.find_by_price_range('7.24', '9.99')).to eq(item4)

            # It accepts an integer price
            expect(Item.find_by_price_range(3, 7)).to eq(item5)

            # It accepts a string integer price
            expect(Item.find_by_price_range('3', '7')).to eq(item5)

            # It evaluates the price as greater/less than or equal to
            expect(Item.find_by_price_range(7.53, 8.32)).to eq(item4)
          end
        end

        context 'when there are no items within the price range' do
          it 'returns nil' do
            expect(Item.find_by_price_range(10, 20)).to eq(nil)
          end
        end
      end

      context 'when I provide an invalid price range with a string' do
        it 'returns nil' do
          expect(Item.find_by_price_range('one', 1)).to eq(nil)
          expect(Item.find_by_price_range(1, 'one1')).to eq(nil)
          expect(Item.find_by_price_range('1one', 1)).to eq(nil)
        end
      end

      context 'when I provide a negative minimum or maximum price' do
        it 'returns "bad request"' do
          expect(Item.find_by_price_range(-10, 5)).to eq('bad request')
          expect(Item.find_by_price_range(10, -5)).to eq('bad request')
          expect(Item.find_by_price_range(-10, -5)).to eq('bad request')
        end
      end

      context 'when I provide a minimum price greater than the maximum price' do
        it 'returns "bad request"' do
          expect(Item.find_by_price_range(10, 1)).to eq('bad request')
        end
      end
    end

    describe '.find_by_name' do
      let!(:item1) { create(:item, name: 'BaA') } # Asc Order: 2
      let!(:item2) { create(:item, name: 'baa') } # Asc Order: 5
      let!(:item3) { create(:item, name: 'bAA') } # Asc Order: 4
      let!(:item4) { create(:item, name: 'Baa') } # Asc Order: 3
      let!(:item5) { create(:item, name: 'BAa') } # Asc Order: 1

      context 'when I provide a valid search string' do
        context 'when there are items with a partial match' do
          it 'returns the first item with partial match in case-sensitive alphabetical order' do
            expect(Item.find_by_name('aA')).to eq(item5)
          end
        end

        context 'when there are no items with a partial match' do
          it 'returns nil' do
            expect(Item.find_by_name('cccc')).to eq(nil)
          end
        end
      end

      context 'when I do not provide a valid search string' do
        it 'returns nil' do
          expect(Item.find_by_name).to eq(nil)
        end
      end
    end

    describe '.top_by_revenue' do
      context 'when I provide a quantity' do
        it 'returns the top items by revenue', :aggregate_failures do
          # See /spec/factories/items.rb for #item_with_revenue
          item1 = item_with_revenue(invoice_items_count: 1)
          item2 = item_with_revenue(invoice_items_count: 6)
          item3 = item_with_revenue(invoice_items_count: 4)
          item4 = item_with_revenue(invoice_items_count: 5)
          item5 = item_with_revenue(invoice_items_count: 3)
          item6 = item_with_revenue(invoice_items_count: 2)
          # See /spec/factories/items.rb for #item_without_revenue
          item7 = item_without_revenue(invoice_items_count: 7)
          item8 = item_without_revenue(invoice_items_count: 8)

          top_six_by_revenue = [item2, item4, item3, item5, item6, item1]
          top_three_by_revenue = [item2, item4, item3]

          actual = Item.top_by_revenue(6)
          expect(actual.length).to eq(6)
          expect(actual).to eq(top_six_by_revenue)

          actual = Item.top_by_revenue(3)
          expect(actual.length).to eq(3)
          expect(actual).to eq(top_three_by_revenue)
        end
      end

      context 'when I do not provide a quantity' do
        it 'returns a default of ten items by revenue', :aggregate_failures do
          # See /spec/factories/items.rb for #items_with_random_revenue
          items_with_random_revenue(15)

          actual = Item.top_by_revenue
          expect(actual.length).to eq(10)

          comparison = actual.first.total_revenue > actual.last.total_revenue
          expect(comparison).to be true
        end
      end
    end
  end
end
