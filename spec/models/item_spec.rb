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
  end
end
