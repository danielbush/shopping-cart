class ShoppingCart

  def initialize
    @products = {}
  end

  def add product
    if @products[product.code] then
      @products[product.code][:count] += 1
      @products[product.code][:cost] += product.price
    else
      @products[product.code] = {
        count: 1,
        code: product.code,
        description: product.name,
        price: product.price,
        cost: product.price
      }
    end
  end

  def total
    @products.values.inject(0) { |sum, item|
      sum += (item[:count] * item[:cost])
    }
  end

  # Return array of line items in cart.
  #
  # Suitable for display by a view.

  def items
    @products.values
  end

end
