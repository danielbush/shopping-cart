
RSpec.shared_context "examples", :shared_context => :metadata do

  let(:ult_small) {
    double('Product', { code: 'ult_small', name: 'Unlimited 1G', price: 24.90 })
  }

  let(:ult_medium) {
    double('Product', { code: 'ult_medium', name: 'Unlimited 2G', price: 29.90 })
  }

  let(:ult_large) {
    double('Product', { code: 'ult_large', name: 'Unlimited 5G', price: 44.90 })
  }

  let(:datapack_1G) {
    double('Product', { code: '1gb', name: '1 GB Data-pack', price: 9.90 })
  }

end
