# frozen_string_literal: true

module LegacyTrust
  # Describes Instructions namespace
  module Instruction
    # Describes FiatPayment resources
    module FiatPayment
      class << self
        #
        # POST /instructions/payments/fiat
        #
        # - +opts+: hash that allows to enter :params, :body and :headers
        #
        # Options Hash (opts):
        #  - body: (Hash)
        #   - client_id (Integer)
        #   - source_service_account_id (Integer)
        #   - target_bank_account_id (Integer)
        #   - amount (Decimal) [>= 0.01]
        #   - memo (String)
        #   - purpose_of_payment (String) [Optional]
        #   - supporting_documents (Hash) [Optional]
        #
        def create(opts = {})
          opts = LegacyTrust.attach_global_client_id_to_body(opts)
          opts = LegacyTrust.attach_global_service_account_id_to_body(
            :source_service_account_id, opts
          )
          LegacyTrust.request(:post, '/instructions/payments/fiat', opts)
        end

        #
        # GET /instructions/payments/fiat/{instruction_id}
        #
        # - +opts+: hash that allows to enter :params, :body and :headers
        #
        # Options Hash (opts):
        #  - instruction_id (Integer)
        #
        def fetch(opts = {})
          id = opts.delete(:instruction_id) || 0
          LegacyTrust.request(:get, "/instructions/payments/fiat/#{id}", opts)
        end
      end
    end
  end
end
