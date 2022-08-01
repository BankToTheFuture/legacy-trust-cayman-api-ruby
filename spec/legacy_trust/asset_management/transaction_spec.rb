# frozen_string_literal: true

RSpec.describe LegacyTrustCayman::AssetManagement::Transaction, vcr: true do
  describe '.fetch_all' do
    subject(:method_execution) { described_class.fetch_all(**opts) }
    context 'when invalid params' do
      let(:opts) { {} }

      it_behaves_like 'invalid API setup'

      it 'raises error' do
        expect { method_execution }.to raise_error(LegacyTrustCayman::RequestError)
      end
    end
    context 'when valid params' do
      let(:account_info) do
        LegacyTrustCayman::AssetManagement::Account.fetch_all(params: { c_id: LegacyTrustCayman.global_client_id } )
                                             .body
                                             .first
      end

      let(:opts) { { params: { se_id: account_info[:service_entity_id], aa_id: account_info[:id] } } }

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrustCayman::Result)
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
            :id, :client_id, :service_entity_id, :service_entity_name,
            :asset_symbol, :asset_name, :asset_account_id, :date, :valuation_date, 
            :execution_date, :transaction_number, :reference, :description,
            :qty, :price, :amount, :transaction_type_code)
        end
      end
    end
  end

  describe '.fetch' do
    subject(:method_execution) { described_class.fetch(**opts) }
    context 'when invalid params' do
      let(:opts) { {} }

      it_behaves_like 'invalid API setup'

      it 'raises error' do
        expect { method_execution }.to raise_error(LegacyTrustCayman::RequestError)
      end
    end
    context 'when valid params' do
      let(:account_info) do
        LegacyTrustCayman::AssetManagement::Account.fetch_all(params: { c_id: LegacyTrustCayman.global_client_id } )
                                             .body
                                             .first
      end

      let(:transaction_id) do
        described_class.fetch_all({ params: { se_id: account_info[:service_entity_id], aa_id: account_info[:id] } })
                       .body[:results]
                       .first[:id]
      end

      let(:opts) { { transaction_id: transaction_id } }
      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrustCayman::Result)
      end

      describe 'result' do
        it 'has items' do
          expect(method_execution.body.keys).to contain_exactly(
            :id, :client_id, :service_entity_id, :service_entity_name,
            :asset_symbol, :asset_name, :asset_account_id, :date, :valuation_date, 
            :execution_date, :transaction_number, :reference, :description,
            :qty, :price, :amount, :transaction_type_code, :asset_account_name)
        end
      end
    end
  end
end
