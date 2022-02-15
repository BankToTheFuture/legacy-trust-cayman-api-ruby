# frozen_string_literal: true

module LegacyTrust
  # Describes Service Entities namespace
  module AssetManagement
    # Describes Transaction resources
    module Account
      class << self

        #
        # GET /ams/accounts
        #
        # - +opts+: hash that allows to enter :params, :body and :headers
        #
        # Options Hash (opts):
        #  - params (Hash)
        #    - c_id (Integer)
        #    - se_id (Integer) [Optional]
        #

        def fetch_all(opts = {})
          LegacyTrust.request(:get, '/ams/accounts', opts)
        end

        #
        # GET /ams/accounts/{aa_id}
        #
        # - +opts+: hash that allows to enter :params, :body and :headers
        #
        # Options Hash (opts):
        #  - asset_account_id (Integer)
        #

        def fetch(opts = {})
          aa_id = opts.delete(:asset_account_id)
          LegacyTrust.request(:get, "/ams/accounts/#{aa_id}", opts)
        end
      end
    end
  end
end
