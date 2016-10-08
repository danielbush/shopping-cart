require 'current_rules'
require 'examples'

describe "current pricing rules" do

  include_context 'examples'

  describe "3 for 2 deal" do

    it "should apply 3 for 2 on product code ult_small" do
      PricingRulesManager.instance.rule('3 for 2 / ult_small') do |rule|
        expect(rule.call([ item1, item1, item1 ].count)).to eq 1
      end

    end
  end

end
