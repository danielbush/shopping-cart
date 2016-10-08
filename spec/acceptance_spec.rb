# These are integration tests for shopping cart and pricing rules systems.

require 'shopping_cart'
require 'pricing_rules_factory'
require 'current_rules'
require 'examples'

describe "shopping cart scenarios" do

  include_context 'examples'
  let(:factory) { PricingRulesFactory.new }

  # High-level sketch...

  describe "how cart fetches pricing rules" do
    it "should be able to total and get items" do
      cart = ShoppingCart.new(factory.pricing_rules)
      expect { cart.total }.not_to raise_error
      expect { cart.items }.not_to raise_error
    end
  end

  describe "scenario 1" do

    it "should get total of 94.70" do
      cart = ShoppingCart.new(factory.pricing_rules)
      3.times { cart.add(ult_small) }
      1.times { cart.add(ult_large) }
      expect(cart.total).to eq 94.70
    end

  end

  xdescribe "scenario 2" do
  end

  xdescribe "scenario 3" do
  end

end
