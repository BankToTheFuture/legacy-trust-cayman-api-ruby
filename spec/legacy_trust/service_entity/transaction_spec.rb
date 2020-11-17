# frozen_string_literal: true

RSpec.describe LegacyTrust::ServiceEntity::Transaction, vcr: true do
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
        { service_entity_id: 35, params: { sa_id: 47 } }
      end

      it_behaves_like 'invalid API setup'

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrust::Result)
      end

      describe 'result' do
        it 'has pagination' do
          expect(method_execution.body.keys).to contain_exactly(
            :current_page, :page_size, :total_count, :total_pages, :has_next,
            :has_previous, :results
          )
        end

        it 'has items' do
          expect(method_execution.body[:results].first.keys).to contain_exactly(
            :id, :date, :transaction_number, :amount, :currency, :reference, :description,
            :service_account_name, :service_account_id
          )
        end
      end
    end
  end
end
