require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should have all 4 fields set' do
      @category = Category.new(name: "Test Category")
      @product = @category.products.new({
        name: "Test Product",
        price: 11.11,
        quantity: 11
      })
      expect(@product).to be_valid 
    end

    it 'should have a valid name' do
      @category = Category.new(name: "Test Category")
      @product = @category.products.new({
        name: nil,
        price: 11.11,
        quantity: 11
      })
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it 'should have a valid price' do
      @category = Category.new(name: "Test Category")
      @product = @category.products.new({
        name: "Test Product",
        price: nil,
        quantity: 11
      })
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it 'should have a valid quantity' do
      @category = Category.new(name: "Test Category")
      @product = @category.products.new({
        name: "Test Product",
        price: 11.11,
        quantity: nil
      })
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it 'should have a valid category' do
      @product = Product.new({
        name: "Test Product",
        price: 11.11,
        quantity: 11, 
        category: nil
      })
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  end
end
