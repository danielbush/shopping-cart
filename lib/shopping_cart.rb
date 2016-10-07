class ShoppingCart

  def initialize pricing_rules=nil
    @pricing_rules = pricing_rules
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
    sum = @products.values.inject(0) { |sum, item|
      sum += (item[:count] * item[:cost])
    }
    if @pricing_rules then
      @pricing_rules.call.inject(sum) { |sum, item|
        sum += (item[:count] * item[:cost])
      }
    else
      sum
    end
  end

  # Return array of line items in cart.
  #
  # Suitable for display by a view.

  def items
    if @pricing_rules then
      @products.values + @pricing_rules.call
    else
      @products.values
    end
  end

end
