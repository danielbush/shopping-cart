# These are integration tests for shopping cart and pricing rules systems.

require 'shopping_cart'
require 'pricing_rules_factory'
require 'current_rules'  # loads current rules into pricing rules manager
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

    let(:cart) { ShoppingCart.new(factory.pricing_rules) }

    before(:each) {
      3.times { cart.add(ult_small) }
      1.times { cart.add(ult_large) }
    }

    it "should get total of 94.70" do
      expect(cart.total).to eq 94.70
    end

    it "should show 3 ult_small" do
      line = cart.items.find { |item| item[:code] == 'ult_small' }
      expect(line[:count]).to eq 3
    end

    it "should show 1 ult_large" do
      line = cart.items.find { |item| item[:code] == 'ult_large' }
      expect(line[:count]).to eq 1
    end

  end

  describe "scenario 2" do

    let(:cart) { ShoppingCart.new(factory.pricing_rules) }

    before(:each) {
      2.times { cart.add(ult_small) }
      4.times { cart.add(ult_large) }
    }

    it "should get total of 209.40" do
      expect(cart.total).to eq 209.40
    end

    it "should show 2 ult_small" do
      line = cart.items.find { |item| item[:code] == 'ult_small' }
      expect(line[:count]).to eq 2
    end

    it "should show 4 ult_large" do
      line = cart.items.find { |item| item[:code] == 'ult_large' }
      expect(line[:count]).to eq 4
    end

  end

  describe "scenario 3" do

    let(:cart) { ShoppingCart.new(factory.pricing_rules) }

    before(:each) {
      1.times { cart.add(ult_small) }
      2.times { cart.add(ult_medium) }
    }

    it "should get total of 84.70" do
      expect(cart.total).to eq 84.70
    end

    it "should show 1 ult_small" do
      line = cart.items.find { |item| item[:code] == 'ult_small' }
      expect(line[:count]).to eq 1
    end

    it "should show 2 ult_medium" do
      line = cart.items.find { |item| item[:code] == 'ult_medium' }
      expect(line[:count]).to eq 2
    end

    it "should show 2 x 1G data-packs" do
      line = cart.items.find { |item| item[:for_code] == '1gb' }
      expect(line[:count]).to eq 2
    end

  end

  describe "scenario 4" do

    let(:cart) { ShoppingCart.new(factory.pricing_rules) }
    let(:promo_code) { 'I<3AMAYSIM' }

    before(:each) {
      1.times { cart.add(ult_small, promo_code) }
      1.times { cart.add(datapack_1G) }
    }

    it "should get total of 31.32" do
      expect(cart.total).to eq 31.32
    end

    it "should show 1 ult_small" do
      line = cart.items.find { |item| item[:code] == 'ult_small' }
      expect(line[:count]).to eq 1
    end

    it "should show 1 x 1G data-packs" do
      line = cart.items.find { |item| item[:code] == '1gb' }
      expect(line[:count]).to eq 1
    end

  end

end
