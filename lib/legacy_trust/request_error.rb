# frozen_string_literal: true

module LegacyTrust
  # Describes API request error
  class RequestError < StandardError
    attr_reader :status, :trace_id, :errors, :body

    def initialize(error_data)
      super(error_data[:title])
      @status = error_data[:status]
      @trace_id = error_data[:trace_id]
      @errors = error_data[:errors]
      @body = error_data
    end
  end
end
