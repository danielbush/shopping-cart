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
    self.items.inject(0) { |sum, item|
      sum += (item[:count] * item[:cost])
    }
  end

  # Return array of line items in cart.
  #
  # Suitable for display by a view.

  def items
    line_items_for_products + line_items_for_rules
  end

  private

  def line_items_for_products
    @products.values
  end

  def line_items_for_rules
    @pricing_rules ? @pricing_rules.call : []
  end

end
