require 'shopping_cart'
require 'pp'

describe ShoppingCart do

  it "can be instantiated with no pricing rules" do
    expect{ ShoppingCart.new }.not_to raise_error
  end

  it "should initialise with a total of 0" do
    expect(ShoppingCart.new.total).to eq 0
  end

  context ShoppingCart, "#add" do
    it "should increase the cart total" do
      product = double('Product', { code: 'ult_small', name: 'Unlimited 1G', price: 10 })
      cart = ShoppingCart.new
      cart.add(product)
      expect(cart.total).to eq(10)
    end
  end

end
