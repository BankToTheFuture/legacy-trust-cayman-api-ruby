# frozen_string_literal: true

RSpec.describe LegacyTrustCayman::Instruction::FiatDeposit, vcr: true do
  describe '.create' do
    subject(:method_execution) { described_class.create(**opts) }

    context 'when invalid params' do
      let(:opts) { {} }

      it_behaves_like 'invalid API setup'

      it 'raises error' do
        expect { method_execution }.to raise_error(LegacyTrustCayman::RequestError)
      end
    end

    context 'when valid params' do
      let(:opts) do
        { body: { source_bank_account_id: 40, source_of_funds: 'Salary', amount: 100.5 } }
      end

      it_behaves_like 'invalid API setup'

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrustCayman::Result)
      end

      describe 'result' do
        it 'has attributes' do
          expect(method_execution.body.keys).to contain_exactly(
            :id, :date_created, :reference_number, :amount, :currency, :status,
            :target_client_id, :target_client_name, :target_bank_account_beneficiary_name,
            :target_bank_account_number, :target_bank_name, :target_bank_swift,
            :target_service_entity_id, :target_service_entity_name,
            :target_service_account_id, :target_service_account_number,
            :source_bank_account_id, :source_bank_account_number,
            :source_bank_account_owner, :source_bank_name, :source_bank_swift,
            :source_of_funds, :supporting_document
          )
        end
      end
    end
  end
end
