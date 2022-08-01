# frozen_string_literal: true

module LegacyTrustCayman
  # Describes Third Party Bank Account resources
  module ThirdPartyBankAccount
    class << self
      #
      # POST /3rd-party-bank-accounts
      #
      # - +opts+: hash that allows to enter :params, :body and :headers
      #
      # Options Hash (opts):
      #  - body: (Hash)
      #   - client_id (Integer)
      #   - bank_id (Integer)
      #   - account_holder (String)
      #   - account_number (String)
      #   - clearing_code (String) [Optional]
      #   - account_holder_detail (Hash):
      #    - address_line_1 (String)
      #    - address_line_2 (String) [Optional]
      #    - city (String)
      #    - postal_code (String) [Optional]
      #    - state_province (String) [Optional]
      #    - country_id (Integer)
      #    - relationship (String)
      #
      def create(opts = {})
        opts = LegacyTrustCayman.attach_global_client_id_to_body(opts)
        LegacyTrustCayman.request(:post, '/3rd-party-bank-accounts', opts)
      end
    end
  end
end
