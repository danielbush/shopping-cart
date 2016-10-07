class ShoppingCart

  def initialize
    @products = []
  end

  def add product
    @products.push(product)
  end

  def total
    @products.inject(0) { |sum, product| sum += product.price }
  end

  # Return array of line items in cart.
  #
  # Suitable for display by a view.

  def items
    []
  end

end
