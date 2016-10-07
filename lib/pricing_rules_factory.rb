
# Simple factory to get a pricing rules manager.
#
# Here, it is hard-wired to run PricingRulesManger which defines
# pricing rules using code.
# But Maybe we want to make a sophisticated pricing rules engine
# that can be configured without writing code.
# This class could be configured at start up time to select
# a given strategy.

# TODO: hard-wiring in use of this particular rules manager.
require 'pricing_rules_manager'

class PricingRulesFactory

  # Return a pricing rules object.
  #
  # The returned object must support #call(items, promo_code).
  # Simplest example would be:
  # 
  #     lambda { |*args| [] }

  def pricing_rules
    PricingRulesManager
  end

end
