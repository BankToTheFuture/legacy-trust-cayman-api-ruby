# frozen_string_literal: true

module LegacyTrust
  # Describes every result returned by the API
  class Result
    attr_reader :status, :body

    def initialize(status:, body:)
      @status = status
      @body = body
    end
  end
end
