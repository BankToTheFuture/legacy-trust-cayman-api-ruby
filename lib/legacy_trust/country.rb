# frozen_string_literal: true

module LegacyTrust
  # Describes Country resource
  module Country
    class << self
      #
      # GET /countries
      #
      def fetch_all
        LegacyTrust.request(:get, '/countries')
      end
    end
  end
end
