# These are integration tests for shopping cart and pricing rules systems.

require 'shopping_cart'
require 'pricing_rules_factory'
require 'examples'

describe "shopping cart scenarios" do

  include_context 'examples'

  # High-level sketch...

  describe "how cart fetches pricing rules" do
    it "should be able to total and get items" do
      factory = PricingRulesFactory.new
      cart = ShoppingCart.new(factory.pricing_rules)
      expect { cart.total }.not_to raise_error
      expect { cart.items }.not_to raise_error
    end
  end

  xdescribe "scenario 1" do
  end
  xdescribe "scenario 2" do
  end
  xdescribe "scenario 3" do
  end
end
