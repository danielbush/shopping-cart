require 'shopping_cart'
require 'pp'

describe ShoppingCart do

  let(:product1) {
    double('Product', { code: 'prod1-code', name: 'prod1-name', price: 10 })
  }
  let(:product2) {
    double('Product', { code: 'prod2-code', name: 'prod2-name', price: 15 })
  }

  # Line items.

  let(:line1) {
    { code: 'prod1-code', description: 'prod1-name', count: 1, price: 10, cost: 10 }
  }
  let(:line2) {
    { code: 'prod2-code', description: 'prod2-name', count: 1, price: 15, cost: 15 }
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
      expect(cart.items).to eq([ line1, line2 ])
    end

    it "should aggregate products with same code" do
      cart = ShoppingCart.new
      cart.add(product1)
      cart.add(product1)
      line = line1.merge(count: 2, cost: 20)
      expect(cart.items).to eq([ line ])

    end
  end

  context "with pricing rules" do

    let(:extra_line) {
      { code: 'extra-code', description: 'extra-desc',
        count: 1, price: 10, cost: 10 }
    }

    # PricingRules#call is expected to return an array of line items.

    let(:pricing_rules) {
      double('PricingRules', { call: [ extra_line ] })
    }

    it "should instantiate with pricing_rules" do
      expect { ShoppingCart.new(pricing_rules) }.not_to raise_error
    end

    describe ShoppingCart, "#items" do

      it "should add additional items received from pricing_rules" do
        cart = ShoppingCart.new(pricing_rules)
        expect(cart.items).to eq [ extra_line ]
      end

    end

    describe ShoppingCart, "#total" do

      it "should add line item values to the total" do
        cart = ShoppingCart.new(pricing_rules)
        expect(cart.total).to eq 10
      end

    end

  end

end
