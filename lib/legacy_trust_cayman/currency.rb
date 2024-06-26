# frozen_string_literal: true

module LegacyTrustCayman
  # Describes Currency resource
  module Currency
    class << self
      #
      # GET /currencies
      #
      # - +opts+: hash that allows to enter :params, :body and :headers
      #
      # Options Hash (opts):
      #  - params: (Hash) - additional query parameters of the request
      #   - :currency_class (String) [Optional]
      #
      def fetch_all(opts = {})
        LegacyTrustCayman.request(:get, '/currencies', opts)
      end
    end
  end
end
