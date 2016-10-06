require 'shopping_cart'

describe ShoppingCart do
  it "can be instantiated with no pricing rules" do
    expect{ ShoppingCart.new }.not_to raise_error
  end
end
