# frozen_string_literal: true

RSpec.describe LegacyTrust::Bank, vcr: true do
  describe '.fetch_all' do
    subject(:method_execution) { described_class.fetch_all(**opts) }

    context 'when no params' do
      let(:opts) { {} }

      it_behaves_like 'invalid API setup'

      it 'raises error' do
        expect { method_execution }.to raise_error(LegacyTrust::RequestError)
      end
    end

    context 'when filtering by swift code' do
      let(:opts) { { params: { swift_code: 'BREXPLPWMBK' } } }

      it_behaves_like 'invalid API setup'

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrust::Result)
      end

      describe 'result' do
        it 'contains number of items' do
          result = method_execution
          expect(result.body.size).to be(1)
        end

        it 'contains items that are banks' do
          result = method_execution
          expect(result.body.first.keys).to contain_exactly(
            :id, :name, :swift_code, :country_id, :city, :branch, :is_deleted
          )
        end
      end
    end

    context 'when filtering by name' do
      let(:opts) { { params: { name: 'MBANK S.A.' } } }

      it_behaves_like 'invalid API setup'

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrust::Result)
      end

      describe 'result' do
        it 'contains number of items' do
          result = method_execution
          expect(result.body.size).to be(39)
        end

        it 'contains items that are banks' do
          result = method_execution
          expect(result.body.first.keys).to contain_exactly(
            :id, :name, :swift_code, :country_id, :city, :branch, :is_deleted
          )
        end
      end
    end
  end
end
