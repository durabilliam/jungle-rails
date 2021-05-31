require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "saves product to database with all 4 fields saved successfully" do
      category = Category.create(name: "Video Games")
      product = Product.create(name: "Dead My Head 5 - Return of Brains", price: 7265, quantity: 1500, category: category)
      expect(product).to be_present
    end

    it "does not save product to database if name is missing" do
      category = Category.create(name: "Video Games")
      product = Product.create(name: nil, price: 7265, quantity: 1500, category: category)
      expect(product.errors.full_messages).to include "Name can't be blank"
    end

    it "does not save product to database if price_cents is not a number" do
      category = Category.create(name: "Video Games")
      product = Product.create(name: "Dead My Head 5 - Return of Brains", price_cents: "one dollar", quantity: 1500, category: category)
      expect(product.errors.full_messages).to include "Price cents is not a number"
    end

    it "does not save product to database if price_cents is missing" do
      category = Category.create(name: "Video Games")
      product = Product.create(name: "Dead My Head 5 - Return of Brains", price_cents: nil, quantity: 1500, category: category)
      expect(product.errors.full_messages).to include "Price cents can't be blank"
    end

    it "does not save product to database if quantity is missing" do
      category = Category.create(name: "Video Games")
      product = Product.create(name: "Dead My Head 5 - Return of Brains", price: 7265, quantity: nil, category: category)
      expect(product.errors.full_messages).to include "Quantity can't be blank"
    end

    it "does not save product to database if category is missing" do
      category = Category.create(name: "Video Games")
      product = Product.create(name: "Dead My Head 5 - Return of Brains", price: 7265, quantity: 1500, category: nil)
      expect(product.errors.full_messages).to include "Category can't be blank"
    end

  end
end
