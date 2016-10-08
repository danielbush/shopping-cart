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

  describe PricingRulesManager, '#call' do
    let(:item1) { { code: 'code1' } }
    let(:rule_itemA) { { code: 'codeA' } }
    let(:rule_itemB) { { code: 'codeB' } }

    it "should call rules using keyword args" do
      expect { |b|
        manager.rule('ruleA', &b)
        manager.call([])
      }.to yield_with_args(items: [], promo_code: nil)
    end

    it "should concatenate all rule output" do
      ruleA = lambda { |items, promo_code=nil| [ rule_itemA ] }
      ruleB = lambda { |items, promo_code=nil| [ rule_itemB ] }
      manager.rule('ruleA', &ruleA)
      manager.rule('ruleB', &ruleB)
      expect(manager.call([ item1 ])).to eq([ rule_itemA, rule_itemB ])
    end

  end

  describe PricingRulesManager, '#rule_for' do

    it "should return a rule in a block if it exists" do
      ruleA = lambda { |items, promo_code=nil| [ rule_itemA ] }
      manager.rule('ruleA', &ruleA)
      expect { |proc| manager.rule_for('ruleA', &proc ) }.to yield_with_args(ruleA)
    end

    it "should raise rule not found error if rule not found" do
      expect { |proc| manager.rule_for('ruleA', &proc ) }.to raise_error PricingRulesManager::RuleNotFound
    end

  end

end
