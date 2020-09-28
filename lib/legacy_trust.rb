# frozen_string_literal: true

require 'legacy_trust/result'
require 'legacy_trust/request_error'
require 'legacy_trust/setup_error'
require 'legacy_trust/currency'
require 'awrence'
require 'oauth2'
require 'plissken'

# LegacyTrust API wrapper
module LegacyTrust
  class << self
    attr_accessor :client_id, :client_secret

    ACCESS_TOKEN_BASE_URL = 'https://auth.smarttrust.welton.ee'
    ACCESS_TOKEN_ENDPOINT = 'connect/token'
    ACCESS_TOKEN_SCOPE = 'PartnerApi'
    API_BASE_HOST = 'partner-api.smarttrust.welton.ee'

    #
    # - +method+: HTTP method; lowercase symbol, e.g. :get, :post etc.
    # - +path+: method path without query params
    # - +opts+: hash that allows to enter :params, :body and :headers
    #
    # Options Hash (opts):
    #  - :params (Hash) - additional query parameters for the URL of the request
    #  - :body (Hash, String) - the body of the request
    #  - :headers (Hash) - http request headers
    #
    # Raises LegacyTrust::RequestError if response code != 200
    #
    def request(method, path, opts = {})
      oauth_result = oauth_token.request(
        method, build_api_url(path), map_options(opts)
      )
      build_result(oauth_result)
    rescue OAuth2::Error => e
      handle_request_error(e)
    end

    private

    def oauth_token
      validate_setup!
      client = OAuth2::Client.new(
        client_id,
        client_secret,
        site: ACCESS_TOKEN_BASE_URL,
        token_url: ACCESS_TOKEN_ENDPOINT
      )
      client.client_credentials.get_token(scope: ACCESS_TOKEN_SCOPE)
    end

    def build_api_url(path)
      URI::HTTPS.build(host: API_BASE_HOST, path: path)
    end

    def build_result(oauth_result)
      response_body = JSON.parse(oauth_result.body, symbolize_names: true)
      LegacyTrust::Result.new(
        status: oauth_result.status,
        body: map_response_body(response_body)
      )
    end

    def handle_request_error(oauth_exception)
      error_data = JSON.parse(oauth_exception.message, symbolize_names: true)
      error_data = map_response_body(error_data)
      raise LegacyTrust::RequestError, error_data
    end

    def validate_setup!
      return if client_id && client_secret

      raise LegacyTrust::SetupError, 'client_id or client_secret is missing'
    end

    def map_options(opts = {})
      mapped_opts = {}
      %i[params body headers].each do |key|
        next unless opts[key]

        mapped_opts.merge!(key => opts[key].to_camelback_keys)
      end
      mapped_opts
    end

    def map_response_body(body)
      body.to_snake_keys
    end
  end
end
