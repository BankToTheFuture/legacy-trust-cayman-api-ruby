# frozen_string_literal: true

module LegacyTrustCayman
  # Describes Service Entities namespace
  module ServiceEntity
    # Describes Transaction resources
    module Transaction
      class << self
        #
        # GET /service-entities/{id}/transactions
        #
        # - +opts+: hash that allows to enter :params, :body and :headers
        #
        # Options Hash (opts):
        #  - service_entity_id (Integer)
        #  - params: (Hash) - additional query parameters of the request
        #   - sa_id (Integer) [Optional]
        #   - p_i (Integer) [Optional]
        #   - p_s (Integer) [Optional]
        #
        def fetch_all(opts = {})
          id = opts.delete(:service_entity_id)
          LegacyTrustCayman.request(:get, "/service-entities/#{id}/transactions", opts)
        end
      end
    end
  end
end
