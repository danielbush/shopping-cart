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

end
