require 'rails_helper'

RSpec.describe Listing, type: :model do
  describe '商品の出品' do
    before do
      @listing = FactoryBot.build(:listing)
    end

    context '出品がうまくいくとき' do

      it '必要項目が全て正しければ登録できる'do
        expect(@listing).to be_valid
      end

    end

    context '出品がうまくいかないとき' do
      it '出品画像が空だと出品できない' do
        @listing.image = nil
        @listing.valid?
        expect(@listing.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空だと出品できない' do
        @listing.product = ''
        @listing.valid?
        expect(@listing.errors.full_messages).to include("Product can't be blank")
      end

      it '商品の説明が空だと出品できない' do
        @listing.explanation = ''
        @listing.valid?
        expect(@listing.errors.full_messages).to include("Explanation can't be blank")
      end

      it 'カテゴリーが空だと出品できない' do
        @listing.category_id = ''
        @listing.valid?
        expect(@listing.errors.full_messages).to include('Category is not a number')
      end

      it '商品の状態が空だと出品できない' do
        @listing.status_id = 1
        @listing.valid?
        expect(@listing.errors.full_messages).to include('Status must be other than 1')
      end

      it '配送料の負担が空だと出品できない' do
        @listing.delivery_id = 1
        @listing.valid?
        expect(@listing.errors.full_messages).to include('Delivery must be other than 1')
      end

      it '発送元の地域が空だと出品できない' do
        @listing.area_id = 1
        @listing.valid?
        expect(@listing.errors.full_messages).to include('Area must be other than 1')
      end

      it '発送までの日数が空だと出品できない' do
        @listing.day_id = 1
        @listing.valid?
        expect(@listing.errors.full_messages).to include('Day must be other than 1')
      end

      it '価格が空だと出品できない' do
        @listing.price = ''
        @listing.valid?
        expect(@listing.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が全角だと保存できない' do
        @listing.price = '５０００'
        @listing.valid?
        expect(@listing.errors.full_messages).to include('Price is out of setting range')
      end

      it '価格が299円以下であれば出品できない' do
        @listing.price = 299
        @listing.valid?
        expect(@listing.errors.full_messages).to include('Price is out of setting range')
      end

      it '価格が1,000,000,000以上であれば出品できない' do
        @listing.price = 1_000_000_000
        @listing.valid?
        expect(@listing.errors.full_messages).to include('Price is out of setting range')
      end
    end
  end
end
