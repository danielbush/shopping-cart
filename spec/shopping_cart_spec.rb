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

      it "should pass items to pricing rules" do
        expect(pricing_rules).to receive(:call).with([ line1 ], nil)
        cart = ShoppingCart.new(pricing_rules)
        cart.add(product1)
        cart.total
      end

      it "should pass promo code to pricing rules" do
        expect(pricing_rules).to receive(:call).with([ line1 ], 'promo-code-1')
        cart = ShoppingCart.new(pricing_rules)
        cart.add(product1, 'promo-code-1')
        cart.total
      end

      it "should pass promo code to pricing rules if 2nd #add has no promo code" do
        expect(pricing_rules).to receive(:call).with([ line1, line2 ], 'promo-code-1')
        cart = ShoppingCart.new(pricing_rules)
        cart.add(product1, 'promo-code-1')
        cart.add(product2)
        cart.total
      end

    end

  end

  context "when pricing rules returns a discount (eg promo code)" do

    let(:promo_code) { 'promo-code-1' }

    let(:discount_line) {
      { discount_rate: 0.1, code: 'promo-code-1' }
    }

    let(:line1) {
      { code: 'prod1-code', description: 'prod1-name', count: 1, price: 10, cost: 10 }
    }

    let(:pricing_rules) {
      double('PricingRules', { call: [ discount_line ] })
    }

    describe ShoppingCart, "#discount_rate" do

      it "should return first discount rate" do
        cart = ShoppingCart.new(pricing_rules)
        expect(cart.discount_rate).to eq 0.1
      end

    end

    describe ShoppingCart, "#total" do

      # This ensures our cart won't trip up on a discount line which
      # doesn't have a cost - it has to be calculated over all items.

      it "should total non-discount lines and apply discount" do
        cart = ShoppingCart.new(pricing_rules)
        cart.add(product1, promo_code)
        expect(cart.total).to eq 9
      end

    end

    describe ShoppingCart, "#items" do

      it "should display the discount in #items" do
        cart = ShoppingCart.new(pricing_rules)
        expect(cart.items).to include discount_line
      end

    end

  end


end
