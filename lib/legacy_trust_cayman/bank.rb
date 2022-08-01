# frozen_string_literal: true

module LegacyTrustCayman
  # Describes Bank resources
  module Bank
    class << self
      #
      # GET /banks/search
      #
      # - +opts+: hash that allows to enter :params, :body and :headers
      #
      # Options Hash (opts):
      #  - params: (Hash)
      #   - name (String)
      #   - swift_code (String)
      #
      def fetch_all(opts = {})
        LegacyTrustCayman.request(:get, '/banks/search', opts)
      end
    end
  end
end
