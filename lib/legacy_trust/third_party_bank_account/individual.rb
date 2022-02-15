# frozen_string_literal: true

module LegacyTrust
  # Describes ThirdPartyBankAccount namespace
  module ThirdPartyBankAccount
    # Describes Individual resources
    module Individual
      class << self
        #
        # # POST /3rd-party-bank-accounts/individual
        #
        # - +opts+: hash that allows to enter :params, :body and :headers
        #
        # Options Hash (opts):
        #  - body: (Hash)
        #   - client_id (Integer)
        #   - bank_id (Integer)
        #   - account_number (String)
        #   - clearing_code (String) [Optional]
        #   - bank_branch_code (String) [Optional]
        #   - bank_account_holder_details (Hash):
        #    - first_name (String)
        #    - middle_name (String) [Optional]
        #    - last_name (String)
        #    - birthday (String) [Date]
        #    - gender (String)
        #    - citizenship_id (Integer)
        #    - place_of_birth_country_id (Integer)
        #    - identity_document_id (String)
        #    - identity_document_issued_country_id (Integer)
        #    - identity_document_type (Integer, Enum)
        #    - identity_proof (Hash)
        #      - base64 (String)
        #      - file_name (String)
        #      - content_type (String)
        #    - phone (Hash)
        #      - phone_number (String)
        #      - country_id (Integer)
        #      - country_code (Integer)
        #      - type (Integer)
        #    - residential_address (Hash)
        #      - line1 (String)
        #      - line2 (String) [Optional]
        #      - city (String)
        #      - postal_code (String) [Optional]
        #      - state_province (String) [Optional]
        #      - country_id (Integer)
        #    - residential_address_proof_document_type (Integer, Enum)
        #    - residential_address_proof (Hash)
        #      - base64 (String)
        #      - file_name (String)
        #      - content_type (String)
        #    - email (String)
        #    - relationship (String)
        #    - client_reference (String) [Optional]

        def create(opts = {})
          opts = LegacyTrust.attach_global_client_id_to_body(opts)
          LegacyTrust.request(:post, '/3rd-party-bank-accounts/individual', opts)
        end
      end
    end
  end
end
