# frozen_string_literal: true

module LegacyTrust
  # Describes Instructions namespace
  module Instruction
    # Describes FiatDeposit resources
    module FiatDeposit
      class << self
        #
        # POST /instructions/deposits-fiat
        #
        # - +opts+: hash that allows to enter :params, :body and :headers
        #
        # Options Hash (opts):
        #  - headers: (Hash)
        #   - :client_id (Integer)
        #  - body: (Hash)
        #   - service_account_id (Integer)
        #   - client_bank_account_id (Integer)
        #   - amount (Decimal)
        #   - source_of_funds (String) [Optional]
        #   - purpose_of_payment (String) [Optional]
        #   - supporting_document (Hash) [Optional]
        #
        def create(opts = {})
          opts = LegacyTrust.attach_global_service_account_id_to_body(opts)
          LegacyTrust.request(:post, '/instructions/deposits-fiat', opts)
        end
      end
    end
  end
end
