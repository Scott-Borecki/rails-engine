require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '.find_all_by_name' do
    let!(:item1) { create(:item, name: 'BaA') } # Asc Order: 2
    let!(:item2) { create(:item, name: 'bac') } # Asc Order: 5
    let!(:item3) { create(:item, name: 'bAA') } # Asc Order: 4
    let!(:item4) { create(:item, name: 'Bab') } # Asc Order: 3
    let!(:item5) { create(:item, name: 'BAa') } # Asc Order: 1

    let(:items_aa) { [item5, item1, item3] }

    context 'when I provide a valid search string' do
      context 'when there are items with a partial match' do
        it 'returns the items by case-sensitive alphabetical order' do
          expect(Item.find_all_by_name('aA')).to eq(items_aa)
        end
      end

      context 'when there are no items with a partial match' do
        it 'returns nil' do
          expect(Item.find_all_by_name('cccc')).to eq([])
        end
      end
    end

    context 'when I do not provide a valid search string' do
      it 'returns nil' do
        expect(Item.find_all_by_name).to eq(nil)
      end
    end
  end
end
