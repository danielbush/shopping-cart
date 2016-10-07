# These are integration tests for shopping cart and pricing rules systems.

require 'shopping_cart'
require 'pricing_rules_manager'


describe "shopping cart scenarios" do

  let(:ult_small) {
    double('Product', { code: 'ult_small', name: 'Unlimited 1G', price: 24.90 })
  }
  let(:ult_medium) {
    double('Product', { code: 'ult_medium', name: 'Unlimited 2G', price: 29.90 })
  }
  let(:ult_large) {
    double('Product', { code: 'ult_large', name: 'Unlimited 5G', price: 44.90 })
  }
  let(:datapack_1G) {
    double('Product', { code: '1gb', name: '1 GB Data-pack', price: 9.90 })
  }

  # High-level sketch...

  describe "how cart fetches pricing rules" do
    it "should be able to total and get items" do
      manager = PricingRulesManager.new
      cart = ShoppingCart.new(manager.pricing_rules)
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
