# frozen_string_literal: true

RSpec.describe LegacyTrust::Currency, vcr: true do
  describe '.fetch_all' do
    subject(:method_execution) { described_class.fetch_all(**opts) }

    context 'when no params' do
      let(:opts) { {} }

      it_behaves_like 'invalid API setup'

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrust::Result)
      end

      describe 'result' do
        it 'contains number of items' do
          result = method_execution
          expect(result.body.size).to be(11)
        end

        it 'contains items that are currencies' do
          result = method_execution
          expect(result.body.first.keys).to contain_exactly(
            :symbol, :name, :class, :decimal_places
          )
        end
      end
    end

    context 'when filtering by class' do
      let(:opts) { { params: { currency_class: currency_class } } }
      let(:currency_class) { 'Fiat' }

      it_behaves_like 'invalid API setup'

      it 'returns result' do
        expect(method_execution).to be_a(LegacyTrust::Result)
      end

      describe 'result' do
        it 'contains number of items' do
          result = method_execution
          expect(result.body.size).to be(7)
        end

        it 'contains items that are currencies' do
          result = method_execution
          expect(result.body.first.keys).to contain_exactly(
            :symbol, :name, :class, :decimal_places
          )
        end

        it 'contains items from selected class' do
          result = method_execution
          expect(result.body.map { |c| c[:class] }.uniq).to(
            contain_exactly(currency_class)
          )
        end
      end
    end
  end
end
