# frozen_string_literal: true

module LegacyTrustCayman
  # Describes Instructions namespace
  module Instruction
    # Describes FiatDeposit resources
    module FiatDeposit
      class << self
        #
        # POST /instructions/deposits/fiat
        #
        # - +opts+: hash that allows to enter :params, :body and :headers
        #
        # Options Hash (opts):
        #  - body: (Hash)
        #   - client_id (Integer)
        #   - target_service_account_id (Integer)
        #   - source_bank_account_id (Integer)
        #   - amount (Decimal) [>=0.0]
        #   - source_of_funds (String)
        #   - purpose_of_payment (String) [Optional]
        #   - supporting_document (Hash) [Optional]
        #
        def create(opts = {})
          opts = LegacyTrustCayman.attach_global_client_id_to_body(opts)
          opts = LegacyTrustCayman.attach_global_service_account_id_to_body(
            :target_service_account_id, opts
          )
          LegacyTrustCayman.request(:post, '/instructions/deposits/fiat', opts)
        end
      end
    end
  end
end
