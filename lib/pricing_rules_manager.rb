# A class object that allows us to define pricing rules using code.
#
# PricingRulesManager and each rule should be an object with interface:
# 
#     #call items, promo_code=nil

class PricingRulesManager

  def self.instance
    @@instance ||= PricingRulesManager.new
  end

  # Return list of the current rules.

  def rules
    @rules ||= []
  end

  # Apply rules to items with optional promo_code.

  def call items, promo_code=nil
    []
  end

  # Add a rule to this manager.

  def rule name, &proc
    self.rules.push({ name: name, rule: proc })
  end

end
