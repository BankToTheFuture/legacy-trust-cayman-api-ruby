# frozen_string_literal: true

RSpec.describe LegacyTrustCayman::Bank do
  describe '.fetch_all' do
    subject(:method_execution) { described_class.fetch_all(**opts) }

    context 'when filtering by swift code' do
      let(:opts) { { params: { swift_code: 'BREXPLPWMBK' } } }
      let(:bank) do
        {
          id: 1,
          name: 'MBANK S.A.',
          swift_code: 'BREXPLPWMBK',
          country_id: 1,
          city: 'Warsaw',
          branch: 'Main',
          is_deleted: false
        }
      end
      let(:api_result) do
        LegacyTrustCayman::Result.new(
          status: 200,
          body: {
            current_page: 1,
            page_size: 50,
            total_count: 1,
            total_pages: 1,
            has_next: false,
            has_previous: false,
            results: [bank]
          }
        )
      end

      before do
        allow(LegacyTrustCayman).to receive(:request).and_return(api_result)
      end

      it 'calls the paginated banks endpoint' do
        method_execution

        expect(LegacyTrustCayman).to have_received(:request).with(:get, '/banks', opts)
      end

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrustCayman::Result)
      end

      it 'keeps the previous array response shape' do
        expect(method_execution.body).to eq([bank])
      end
    end

    context 'when response is not paginated' do
      let(:opts) { { params: { name: 'MBANK S.A.' } } }
      let(:api_result) { LegacyTrustCayman::Result.new(status: 200, body: []) }

      before do
        allow(LegacyTrustCayman).to receive(:request).and_return(api_result)
      end

      it 'returns the original result' do
        expect(method_execution).to eq(api_result)
      end
    end
  end
end
