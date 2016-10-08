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
    self.rules.flat_map { |rule| rule[:rule].call(items: items, promo_code: promo_code) }
  end

  # Add a rule to this manager.

  def rule name, &proc
    self.rules.push({ name: name, rule: proc })
  end

  # Convenience wrapper to fetch a rule or throw exception.

  def rule_for name, &proc
    rule = self.rules.find { |rule| rule[:name] == name }
    raise RuleNotFound, name unless rule
    proc.call(rule[:rule]) if block_given?
    rule
  end

  class RuleNotFound < RuntimeError
  end

end
