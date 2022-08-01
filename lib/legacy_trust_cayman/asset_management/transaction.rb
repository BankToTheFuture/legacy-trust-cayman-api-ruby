# frozen_string_literal: true

module LegacyTrustCayman
  # Describes Service Entities namespace
  module AssetManagement
    # Describes Transaction resources
    module Transaction
      class << self

        #
        # GET /ams/transactions
        #
        # - +opts+: hash that allows to enter :params, :body and :headers
        #
        # Options Hash (opts):
        #  - params (Hash)
        #   - se_id (Integer)
        #   - aa_id (Integer)
        #   - six (Integer) [Optional]
        #   - sd (String) [Date, Optional]
        #   - ed (String) [Date, Optional]
        #   - pi (Integer) [Optional]
        #   - ps (Integer) [Optional]
        #

        def fetch_all(opts = {})
          LegacyTrustCayman.request(:get, '/ams/transactions', opts)
        end

        #
        # GET /ams/transactions
        #
        # - +opts+: hash that allows to enter :params, :body and :headers
        #
        # Options Hash (opts):
        #  - transaction_id (Integer)
        #

        def fetch(opts = {})
          tx_id = opts.delete(:transaction_id)
          LegacyTrustCayman.request(:get, "/ams/transactions/#{tx_id}", opts)
        end
      end
    end
  end
end
