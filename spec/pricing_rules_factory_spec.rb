require 'pricing_rules_factory'

describe PricingRulesFactory do

  describe '#pricing_rules' do

    # So, currently, PricingRulesFactory is hard-wired to return are
    # code-based PricingRulesManager.

    it "should currently return PricingRulesManager" do
      factory = PricingRulesFactory.new
      expect(factory.pricing_rules).to eq PricingRulesManager
    end

  end

end
