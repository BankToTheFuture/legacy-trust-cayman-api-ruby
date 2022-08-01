# frozen_string_literal: true

RSpec.describe LegacyTrustCayman::Country, vcr: true do
  describe '.fetch_all' do
    subject(:method_execution) { described_class.fetch_all }

    it_behaves_like 'invalid API setup'

    it 'returns result' do
      expect(method_execution).to be_a(LegacyTrustCayman::Result)
    end

    describe 'result' do
      it 'contains number of items' do
        result = method_execution
        expect(result.body.size).to be(236)
      end

      it 'contains items that are countries' do
        result = method_execution
        expect(result.body.first.keys).to contain_exactly(
          :id, :name, :iso_numeric, :iso_alpha2, :iso_alpha3, :isd_code,
          :show_postal_code_in_address_forms, :show_state_in_address_forms,
          :is_active, :is_eu_member, :corruption_index, :ml_risk_index,
          :tf_risk, :default_city_in_address_forms, :tax_id_reg_ex_pattern
        )
      end
    end
  end
end
