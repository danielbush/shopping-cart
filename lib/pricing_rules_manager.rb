class PricingRulesManager

  # Return a pricing rules object.
  #
  # The returned object must support #call(items, promo_code).

  def pricing_rules
    lambda {|*args| []}
  end

end
