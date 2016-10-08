require 'current_rules'
require 'examples'

describe "current pricing rules" do

  include_context 'examples'
  let(:manager) { PricingRulesManager.instance }

  describe "3 for 2 deal" do

    let(:item_3x_ult_small) { item_ult_small.merge(count: 3, cost: 3 * ult_small.price) }
    let(:items) {[ item_3x_ult_small ]}
    let(:rule_name) { '3 for 2 / ult_small' }

    it "should apply 3 for 2 on product code ult_small if count >= 3" do
      manager.rule_for(rule_name) do |rule|
        returned_item = {
          code: '3 for 2 / ult_small',
          for_code: 'ult_small',
          count: 1,
          cost: -24.9
        }
        expect(rule.call(items: items)).to eq [ returned_item ]
      end
    end

  end

end
