# frozen_string_literal: true

RSpec.describe LegacyTrust::Instruction::FiatDeposit, vcr: true do
  describe '.create' do
    subject(:method_execution) { described_class.create(**opts) }

    context 'when invalid params' do
      let(:opts) { {} }

      it_behaves_like 'invalid API setup'

      it 'raises error' do
        expect { method_execution }.to raise_error(LegacyTrust::RequestError)
      end
    end

    context 'when valid params' do
      let(:opts) { { body: { client_bank_account_id: 36, amount: 100.5 } } }

      it_behaves_like 'invalid API setup'

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrust::Result)
      end

      describe 'result' do
        it 'has attributes' do
          expect(method_execution.body.keys).to contain_exactly(
            :id, :date_created, :reference_number, :bank_name, :bank_account_number, :package_name,
            :service_account_number, :service_account_name, :amount, :currency,
            :supporting_document_s3_key, :status, :transfer_type
          )
        end
      end
    end
  end
end
