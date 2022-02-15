# frozen_string_literal: true

RSpec.describe LegacyTrust::AssetManagement::Account, vcr: true do
  describe '.fetch_all' do
    subject(:method_execution) { described_class.fetch_all(**opts) }
    context 'when invalid params' do
      let(:opts) { { params: { c_id: -190_900_900_900} } }

      it_behaves_like 'invalid API setup'

      it 'raises error' do
        expect { method_execution }.to raise_error(LegacyTrust::RequestError)
      end
    end

    context 'when params are not provided' do
      let(:opts) { {} }

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrust::Result)
      end

      describe 'result' do
        it 'is a collection' do
          expect(method_execution.body).to be_a(Array)
        end

        it 'collection is empty' do
          expect(method_execution.body.first).to be(nil)
        end
      end
    end

    context 'when valid params' do
      let(:opts) { { params: { c_id: LegacyTrust.global_client_id } } }

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrust::Result)
      end

      describe 'result' do
        it 'is a collection' do
          expect(method_execution.body).to be_a(Array)
        end

        it 'contains items that are accounts' do
          expect(method_execution.body.first.keys).to contain_exactly(
            :asset_account_name, :asset_account_number, :asset_name, :asset_symbol, :balance,
            :client_id, :id, :service_entity_id
          )
        end
      end
    end
  end

  describe '.fetch' do
    subject(:method_execution) { described_class.fetch(**opts) }

    let(:aa_id) do
      described_class.fetch_all(params: { c_id: LegacyTrust.global_client_id })
                     .body
                     .first[:id]
    end

    context 'when invalid params' do
      let(:opts) { { params: { c_id: -198_089_089_089_089 } } }

      it_behaves_like 'invalid API setup'

      it 'raises error' do
        expect { method_execution }.to raise_error(LegacyTrust::RequestError)
      end
    end

    context 'when valid params' do
      let(:opts) { { asset_account_id: aa_id } }

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrust::Result)
      end

      describe 'result' do
        it 'contains data that is account' do
          expect(method_execution.body.keys).to contain_exactly(
            :asset_account_name, :asset_account_number, :asset_name, :asset_symbol, :balance,
            :client_id, :id, :service_entity_id, :asset_denomination_currency, :service_entity_name
          )
        end
      end
    end
  end
end
