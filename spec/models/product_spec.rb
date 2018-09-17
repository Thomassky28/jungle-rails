require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    context 'given all fields' do
      it 'save successfully' do
        @category = Category.create({name: 'Grocery'})
        @product = Product.new({name:'candy', price: 2, quantity: 120, category: @category})
        expect(@product.save).to be_truthy
      end
    end

    context 'without giving a name' do
      it 'fail to save' do
        @category = Category.create({name: 'Grocery'})
        @product = Product.new({price: 2, quantity: 120, category: @category})
        @product.save
        expect(@product.errors.full_messages).to include ("Name can't be blank")

      end
    end

    context 'without giving a price' do
      it 'fail to save' do
        @category = Category.create({name: 'Grocery'})
        @product = Product.new({name: 'candy', quantity: 120, category: @category})
        @product.save
        expect(@product.errors.full_messages).to include ("Price can't be blank")
      end
    end

    context 'without giving a quantity' do
      it 'fail to save' do
        @category = Category.create({name: 'Grocery'})
        @product = Product.new({name: 'candy', price: 2, category: @category})
        @product.save
        expect(@product.errors.full_messages).to include ("Quantity can't be blank")
      end
    end



    context 'without giving a category' do
      it 'fail to save' do
        @product = Product.new({name:'candy', price: 2, quantity: 120})
        @product.save
        expect(@product.errors.full_messages).to include ("Category can't be blank")
      end
    end

    # validation tests/examples here
  end
end