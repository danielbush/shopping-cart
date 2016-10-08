require 'pricing_rules_factory'

describe PricingRulesFactory do

  describe '#pricing_rules' do

    # So, currently, PricingRulesFactory is hard-wired to return are
    # code-based PricingRulesManager.

    it "should currently return PricingRulesManager singleton" do
      factory = PricingRulesFactory.new
      expect(factory.pricing_rules).to be_a PricingRulesManager
    end

  end

end
