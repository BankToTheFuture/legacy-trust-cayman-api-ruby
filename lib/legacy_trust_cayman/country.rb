# frozen_string_literal: true

module LegacyTrustCayman
  # Describes Country resource
  module Country
    class << self
      #
      # GET /countries
      #
      def fetch_all
        LegacyTrustCayman.request(:get, '/countries')
      end
    end
  end
end
