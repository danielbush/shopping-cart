require 'pricing_rules_manager'

PricingRulesManager.instance.add_rules do |rule|

  rule '3 for 2 / ult_small' do |items, promo_code|
  end

  rule 'ult_large bulk discount' do |items, promo_code|
  end

  rule 'data-pack bonus for ult_medium' do |items, promo_code|
  end

end

