require 'shopping_cart'
require 'pp'

describe ShoppingCart do

  let(:product1) {
    double('Product', { code: 'prod1-code', name: 'prod1-name', price: 10 })
  }
  let(:product2) {
    double('Product', { code: 'prod2-code', name: 'prod2-name', price: 15 })
  }

  it "can be instantiated with no pricing rules" do
    expect { ShoppingCart.new }.not_to raise_error
  end

  it "should initialise with a total of 0" do
    expect(ShoppingCart.new.total).to eq 0
  end

  describe ShoppingCart, "#add" do
    it "should increase the cart total" do
      cart = ShoppingCart.new
      cart.add(product1)
      expect(cart.total).to eq(10)
    end
  end

  describe ShoppingCart, "#items" do

    it "for empty cart, should return empty array" do
      cart = ShoppingCart.new
      expect(cart.items).to eq []
    end

    it "should display a line for each different item" do
      cart = ShoppingCart.new
      cart.add(product1)
      cart.add(product2)
      line1 = { code: 'prod1-code', description: 'prod1-name',
                count: 1, price: 10, cost: 10 }
      line2 = { code: 'prod2-code', description: 'prod2-name',
                count: 1, price: 15, cost: 15 }
      expect(cart.items).to eq([ line1, line2 ])
    end

    it "should aggregate products with same code" do
      cart = ShoppingCart.new
      cart.add(product1)
      cart.add(product1)
      expect(cart.items).to eq([ { code: 'prod1-code',
                                   description: 'prod1-name',
                                   count: 2,
                                   price: 10,
                                   cost: 20 } ])

    end
  end

end
