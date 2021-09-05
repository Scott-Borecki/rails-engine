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
      let!(:item1) { create(:item, name: 'Boston Red Sox Cap',    unit_price: 19.99) }
      let!(:item2) { create(:item, name: 'bare knuckles',         unit_price: 2.49) }
      let!(:item3) { create(:item, name: 'American Flag',         unit_price: 149.99) }
      let!(:item4) { create(:item, name: 'Crossword Puzzle Book', unit_price: 9.97) }

      context 'when I do not provide any parameters' do
        it 'orders the items by name (case-sensitive) in ascending order (default)' do
          expect(Item.order_by_name).to eq([item3, item1, item4, item2])
        end
      end

      context 'when I provide a parameter "desc"' do
        it 'orders the items by name (case-sensitive) in descending order' do
          expect(Item.order_by_name('desc')).to eq([item2, item4, item1, item3])
        end
      end

      context 'when I provide a parameter other than "desc"' do
        it 'orders the items by name (case-sensitive) in ascending order (default)' do
          expect(Item.order_by_name(123)).to eq([item3, item1, item4, item2])
          expect(Item.order_by_name('des')).to eq([item3, item1, item4, item2])
        end
      end
    end
  end
end
