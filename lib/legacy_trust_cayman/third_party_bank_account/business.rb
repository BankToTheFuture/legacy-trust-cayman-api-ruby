# frozen_string_literal: true

module LegacyTrustCayman
  # Describes ThirdPartyBankAccount namespace
  module ThirdPartyBankAccount
    # Describes Business resources
    module Business
      class << self
        #
        # POST /3rd-party-bank-accounts/business
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
        #    - registered_name (String)
        #    - registration_number (String)
        #    - registration_date (String)
        #    - jurisdiction_country_id (Integer)
        #    - registration_document_proof (Hash)
        #      - base64 (String)
        #      - file_name (String)
        #      - content_type (String)
        #    - phone (Hash)
        #      - phone_number (String)
        #      - country_id (Integer)
        #      - country_code (Integer)
        #      - type (Integer)
        #    - registered_address (Hash)
        #      - line1 (String)
        #      - line2 (String) [Optional]
        #      - city (String)
        #      - postal_code (String) [Optional]
        #      - state_province (String) [Optional]
        #      - country_id (Integer)
        #    - registered_address_proof_type (Integer, Enum)
        #    - registered_address_proof (Hash)
        #      - base64 (String)
        #      - file_name (String)
        #      - content_type (String)
        #    - operating_address (Hash)
        #      - line1 (String)
        #      - line2 (String) [Optional]
        #      - city (String)
        #      - postal_code (String) [Optional]
        #      - state_province (String) [Optional]
        #      - country_id (Integer)
        #    - email (String)
        #    - relationship (String)
        #    - client_reference (String)

        def create(opts = {})
          opts = LegacyTrustCayman.attach_global_client_id_to_body(opts)
          LegacyTrustCayman.request(:post, '/3rd-party-bank-accounts/business', opts)
        end
      end
    end
  end
end
