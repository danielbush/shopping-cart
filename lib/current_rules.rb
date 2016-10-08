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
        cost: item[:count] * -5
      }
    ]
  end
end

manager.rule 'Data-pack bonus / ult_medium' do |items: [], promo_code: nil|
  item = items.find { |item| item[:code] == 'ult_medium' }
  if not item then
    []
  else
    [
      {
        code: 'Data-pack bonus / ult_medium',
        for_code: '1gb',
        count: item[:count],
        cost: 0
      }
    ]
  end
end

manager.rule 'Promo-code I<3AMAYSIM' do |items: [], promo_code: nil|
  if promo_code == 'I<3AMAYSIM' then
    [ { discount_rate: 0.1, code: 'Promo-code I<3AMAYSIM' } ]
  else
    []
  end
end
