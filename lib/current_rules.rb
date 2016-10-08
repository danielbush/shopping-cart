require 'pricing_rules_manager'

manager = PricingRulesManager.instance

# TODO: Defining rules using blocks is a little problematic.
# No returns and weird parameter behaviours when passing arrays.
# We could try switching to lambda's or come up with another
# way to write rules easily.

manager.rule '3 for 2 / ult_small' do |items: [], promo_code: nil|
  item = items.find { |item| item[:code] == 'ult_small' }
  if not item then
    []
  elsif item[:count] < 3 then
    []
  else
    [
      {
        code: '3 for 2 / ult_small',
        for_code: 'ult_small',
        count: 1,
        cost: -24.9
      }
    ]
  end
end

manager.rule 'Bulk discount / ult_large' do |items: [], promo_code: nil|
  item = items.find { |item| item[:code] == 'ult_large' }
  if not item then
    []
  elsif item[:count] <= 3 then
    []
  else
    [
      {
        code: 'Bulk discount / ult_large',
        for_code: 'ult_large',
        count: item[:count],
        cost: item[:count] * -10
      }
    ]
  end
end

manager.rule 'data-pack bonus for ult_medium' do |items, promo_code=nil|
  []
end
