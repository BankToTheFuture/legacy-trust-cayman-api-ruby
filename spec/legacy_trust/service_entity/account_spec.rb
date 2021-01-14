# frozen_string_literal: true

RSpec.describe LegacyTrust::ServiceEntity::Account, vcr: true do
  describe '.create' do
    subject(:method_execution) { described_class.fetch_all(**opts) }

    context 'when invalid params' do
      let(:opts) { {} }

      it_behaves_like 'invalid API setup'

      it 'raises error' do
        expect { method_execution }.to raise_error(LegacyTrust::RequestError)
      end
    end

    context 'when valid params' do
      let(:opts) do
        { service_entity_id: 35 }
      end

      it_behaves_like 'invalid API setup'

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrust::Result)
      end

      describe 'result' do
        it 'is a collection' do
          expect(method_execution.body).to be_a(Array)
        end

        it 'contains items that are accounts' do
          expect(method_execution.body.first.keys).to contain_exactly(
            :id, :currency, :account_number, :account_name, :balance
          )
        end
      end
    end
  end
end
