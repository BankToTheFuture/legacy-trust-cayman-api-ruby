# frozen_string_literal: true

module LegacyTrust
  # Describes Third Party Bank Account resources
  module ThirdPartyBankAccount
    class << self
      #
      # POST /bank-accounts/addthirdparty
      #
      # - +opts+: hash that allows to enter :params, :body and :headers
      #
      # Options Hash (opts):
      #  - headers: (Hash)
      #   - :client_id (Integer)
      #  - body: (Hash)
      #   - bank_id (Integer)
      #   - account_holder (String)
      #   - account_number (String)
      #   - detail (Hash):
      #    - line_1 (String)
      #    - line_2 (String) [Optional]
      #    - city (String)
      #    - postal_code (String) [Optional]
      #    - state_province (String) [Optional]
      #    - country_id (Integer)
      #    - relationship (String)
      #
      def create(opts = {})
        LegacyTrust.request(:post, '/bank-accounts/addthirdparty', opts)
      end
    end
  end
end
