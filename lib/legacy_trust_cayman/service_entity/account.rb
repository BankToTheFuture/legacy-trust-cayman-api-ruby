# frozen_string_literal: true

module LegacyTrustCayman
  # Describes Service Entities namespace
  module ServiceEntity
    # Describes Transaction resources
    module Account
      class << self
        #
        # GET /service-entities/{id}/accounts
        #
        # - +opts+: hash that allows to enter :params, :body and :headers
        #
        # Options Hash (opts):
        #  - service_entity_id (Integer)
        #
        def fetch_all(opts = {})
          id = opts.delete(:service_entity_id)
          LegacyTrustCayman.request(:get, "/service-entities/#{id}/accounts", opts)
        end
      end
    end
  end
end
