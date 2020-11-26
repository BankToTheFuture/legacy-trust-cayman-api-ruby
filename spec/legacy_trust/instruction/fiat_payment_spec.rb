# frozen_string_literal: true

RSpec.describe LegacyTrust::Instruction::FiatPayment, vcr: true do
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
      let(:opts) do
        { body: { target_bank_account_id: 40, amount: 1000.51, memo: 'test' } }
      end

      it_behaves_like 'invalid API setup'

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrust::Result)
      end

      describe 'result' do
        it 'has attributes' do
          expect(method_execution.body.keys).to contain_exactly(
            :source_client_id, :source_client_name, :source_service_entity_id,
            :source_service_entity_name, :source_service_account_id,
            :source_service_account_number, :target_bank_account_owner,
            :target_bank_account_number, :target_bank_name, :target_bank_swift,
            :purpose_of_payment, :id, :date_created, :reference_number, :amount,
            :currency, :status
          )
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
        expect { method_execution }.to raise_error(LegacyTrust::RequestError)
      end
    end

    context 'when valid params' do
      let(:opts) do
        { instruction_id: 133 }
      end

      it_behaves_like 'invalid API setup'

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrust::Result)
      end

      describe 'result' do
        it 'has attributes' do
          expect(method_execution.body.keys).to contain_exactly(
            :source_client_id, :source_client_name, :source_service_entity_id,
            :source_service_entity_name, :source_service_account_id,
            :source_service_account_number, :target_bank_account_owner,
            :target_bank_account_number, :target_bank_name, :target_bank_swift,
            :purpose_of_payment, :id, :date_created, :reference_number, :amount,
            :currency, :status
          )
        end
      end
    end
  end
end
