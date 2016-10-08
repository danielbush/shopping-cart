require 'pricing_rules_manager'

describe PricingRulesManager do

  describe PricingRulesManager, '#call' do

    it "for empty manager, should return empty array" do
      expect(PricingRulesManager.call([])).to eq []
    end

  end

  describe PricingRulesManager, '#rule' do

    it "should add a rule to manager's rules" do
      rule = lambda { |items, promo_code=nil| [] }
      PricingRulesManager.rule('rule1', &rule)
      expect(PricingRulesManager.rules).to eq([{ name: 'rule1', rule: rule }])
    end

  end

end
