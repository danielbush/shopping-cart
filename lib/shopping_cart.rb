class ShoppingCart

  def initialize pricing_rules=nil
    @pricing_rules = pricing_rules
    @products = {}
    @promo_code = nil
  end

  def add product, promo_code=nil
    @promo_code = promo_code if promo_code
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
    sum = self.items.inject(0) { |sum, item|
      sum += (item[:count] * item[:cost]) if item[:cost]
      sum
    }
    if self.discount_rate then
      sum - ( self.discount_rate * sum )
    else
      sum
    end
  end

  # Return array of line items in cart.
  #
  # Suitable for display by a view.

  def items
    line_items_for_products + line_items_for_rules
  end

  # Fetches discount rate to apply to whole cart.
  #
  # TODO: we could tighten this up.

  def discount_rate
    line = line_items_for_rules.find { |line| line.has_key?(:discount_rate) }
    if line
      line[:discount_rate]
    else
      nil
    end
  end

  private

  def line_items_for_products
    @products.values
  end

  # Fetch extra line items based on cart contents.
  #
  # TODO: we could cache/memoise here to only update when we #add.

  def line_items_for_rules
    return [] unless @pricing_rules
    @pricing_rules.call(line_items_for_products, @promo_code)
  end

end
