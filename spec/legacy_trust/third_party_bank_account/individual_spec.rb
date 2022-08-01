# # frozen_string_literal: true

# RSpec.describe LegacyTrustCayman::ThirdPartyBankAccount::Individual, vcr: true do
#   describe '.create' do
#     subject(:method_execution) { described_class.create(**opts) }

#     context 'when invalid params' do
#       let(:opts) { {} }

#       it_behaves_like 'invalid API setup'

#       it 'raises error' do
#         expect { method_execution }.to raise_error(LegacyTrustCayman::RequestError)
#       end
#     end

#     context 'when valid params' do
#       let(:opts) do
#         {
#           body: {
#             bank_id: 49_412,
#             account_number: '27114020040000370241202935',
#             bank_account_holder_details: {
#               first_name: 'Zygmunt',
#               last_name: 'Wieniawa',
#               birthday: '1980-08-24T14:15:22Z',
#               gender: 'male',
#               citizenship_id: 123,
#               place_of_birth_country_id: 26,
#               identity_document_id: 'asdasda',
#               identity_document_issued_country_id: 26,
#               identity_document_type: 5,
#               identity_proof: {
#                 base64: 'dGVzdA==',
#                 file_name: 'id_proof.png',
#                 content_type: 'image/jpeg'
#               },
#               phone: {
#                 phone_number: '555555555',
#                 country_id: 26,
#                 country_code: 48,
#                 type: 1
#               },
#               residential_address: {
#                 line1: 'Zygmunta Poniatowskiego 12',
#                 city: 'Warszawa',
#                 country_id: 26
#               },
#               residential_address_proof_document_type: 1,
#               residential_address_proof: {
#                 base64: 'dGVzdA==',
#                 file_name: 'res_proof.png',
#                 content_type: 'image/jpeg'
#               },
#               relationship: 'Investor',
#               email: 'test@test.com',
#               client_reference: '177'
#             }
#           }
#         }
#       end

#       it_behaves_like 'invalid API setup'

#       it 'returns result' do
#         expect(method_execution).to be_a(LegacyTrustCayman::Result)
#       end

#       describe 'result' do
#         it 'contains BankAccount data' do
#           expect(method_execution.body.keys).to(
#             contain_exactly(
#               :id, :client_id, :client_name, :name, :account_holder, :account_number,
#               :clearing_code, :bank_branch_code, :is_primary, :verification_status, :bank, :client_reference
#             )
#           )
#         end
#       end
#     end
#   end
# end
