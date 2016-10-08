require 'pricing_rules_manager'

manager = PricingRulesManager.instance

manager.rule '3 for 2 / ult_small' do |items, promo_code=nil|
end

manager.rule 'ult_large bulk discount' do |items, promo_code=nil|
end

manager.rule 'data-pack bonus for ult_medium' do |items, promo_code=nil|
end
