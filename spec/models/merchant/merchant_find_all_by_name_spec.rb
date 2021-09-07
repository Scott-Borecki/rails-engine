require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe '.find_all_by_name' do
    let!(:merchant1) { create(:merchant, name: 'BaA') } # Asc Order: 2
    let!(:merchant2) { create(:merchant, name: 'bac') } # Asc Order: 5
    let!(:merchant3) { create(:merchant, name: 'bAA') } # Asc Order: 4
    let!(:merchant4) { create(:merchant, name: 'Bab') } # Asc Order: 3
    let!(:merchant5) { create(:merchant, name: 'BAa') } # Asc Order: 1

    let(:merchants_aa) { [merchant5, merchant1, merchant3] }

    context 'when I provide a valid search string' do
      context 'when there are merchants with a partial match' do
        it 'returns the merchants with partial matches in case-sensitive alphabetical order' do
          expect(Merchant.find_all_by_name('aA')).to eq(merchants_aa)
        end
      end

      context 'when there are no merchants with a partial match' do
        it 'returns an empty array' do
          expect(Merchant.find_all_by_name('cccc')).to eq([])
        end
      end
    end

    context 'when I do not provide a valid search string' do
      it 'returns nil' do
        expect(Merchant.find_all_by_name).to be_nil
      end
    end
  end
end
