require 'pricing_rules_manager'

describe PricingRulesManager do

  let(:manager) { PricingRulesManager.new }

  describe PricingRulesManager, '#call' do

    it "for empty manager, should return empty array" do
      expect(manager.call([])).to eq []
    end

  end

  describe PricingRulesManager, '#rules' do

    it "for empty manager, should return empty array" do
      expect(manager.rules).to eq []
    end

  end

  describe PricingRulesManager, '#rule' do

    it "should add a rule to manager's rules" do
      rule = lambda { |items, promo_code=nil| [] }
      manager.rule('rule1', &rule)
      expect(manager.rules).to eq([{ name: 'rule1', rule: rule }])
    end

  end

end
