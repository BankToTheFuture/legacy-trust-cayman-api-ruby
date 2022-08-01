# frozen_string_literal: true

require 'legacy_trust_cayman/asset_management/account'
require 'legacy_trust_cayman/asset_management/transaction'
require 'legacy_trust_cayman/bank'
require 'legacy_trust_cayman/country'
require 'legacy_trust_cayman/currency'
require 'legacy_trust_cayman/instruction/fiat_deposit'
require 'legacy_trust_cayman/instruction/fiat_payment'
require 'legacy_trust_cayman/result'
require 'legacy_trust_cayman/request_error'
require 'legacy_trust_cayman/service_entity/account'
require 'legacy_trust_cayman/service_entity/transaction'
require 'legacy_trust_cayman/setup_error'
require 'legacy_trust_cayman/third_party_bank_account'
# require 'legacy_trust/third_party_bank_account/individual'
# require 'legacy_trust/third_party_bank_account/business'
require 'legacy_trust_cayman/version'

require 'awrence'
require 'oauth2'
require 'plissken'

# LegacyTrustCayman API wrapper
# rubocop:disable Metrics/ModuleLength
module LegacyTrustCayman
  class << self
    # OAuth authentication keys
    attr_accessor :oauth_client_id, :oauth_client_secret
    # API global keys
    attr_accessor :global_client_id, :global_service_account_id
    # Settings
    attr_accessor :sandbox_mode, :proxy

    TEST_ACCESS_TOKEN_BASE_URL = 'https://fdt-auth.smarttrust.welton.ee'
    TEST_API_BASE_HOST = 'fdt-partner-api.smarttrust.welton.ee'
    LIVE_ACCESS_TOKEN_BASE_URL = 'https://auth.1stdigital.com'
    LIVE_API_BASE_HOST = 'partner-api.1stdigital.com'
    ACCESS_TOKEN_ENDPOINT = 'connect/token'
    ACCESS_TOKEN_SCOPE = 'PartnerApi'

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
    # Raises LegacyTrustCayman::RequestError if response code != 200
    #
    def request(method, path, opts = {})
      oauth_result = oauth_token.request(
        method, build_api_url(path), map_options(opts)
      )
      build_result(oauth_result)
    rescue OAuth2::Error => e
      handle_request_error(e)
    end

    #
    # - +key+: key that refers to the global_service_account_id in body
    # - +opts+: hash that may contain :params, :body and :headers
    #
    # Options Hash (opts):
    #  - :params (Hash) - additional query parameters for the URL of the request
    #  - :body (Hash, String) - the body of the request
    #  - :headers (Hash) - http request headers
    #
    def attach_global_service_account_id_to_body(key, opts = {})
      init_body = {}
      init_body.merge!(key => global_service_account_id) if global_service_account_id
      opts.merge(body: init_body.merge(opts[:body] || {}))
    end

    #
    # - +opts+: hash that may contain :params, :body and :headers
    #
    # Options Hash (opts):
    #  - :params (Hash) - additional query parameters for the URL of the request
    #  - :body (Hash, String) - the body of the request
    #  - :headers (Hash) - http request headers
    #
    def attach_global_client_id_to_body(opts = {})
      init_body = {}
      init_body.merge!(client_id: global_client_id) if global_client_id
      opts.merge(body: init_body.merge(opts[:body] || {}))
    end

    private

    def access_token_base_url
      return TEST_ACCESS_TOKEN_BASE_URL if sandbox_mode

      LIVE_ACCESS_TOKEN_BASE_URL
    end

    def api_base_host
      return TEST_API_BASE_HOST if sandbox_mode

      LIVE_API_BASE_HOST
    end

    def oauth_token
      validate_setup!
      client = OAuth2::Client.new(
        oauth_client_id,
        oauth_client_secret,
        site: access_token_base_url,
        token_url: ACCESS_TOKEN_ENDPOINT,
        connection_opts: client_connection_options # Faraday is initialized with it
      )
      client.client_credentials.get_token(scope: ACCESS_TOKEN_SCOPE)
    end

    def client_connection_options
      { proxy: proxy }.compact
    end

    def build_api_url(path)
      URI::HTTPS.build(host: api_base_host, path: path)
    end

    def build_result(oauth_result)
      response_body = JSON.parse(oauth_result.body, symbolize_names: true)
      LegacyTrustCayman::Result.new(
        status: oauth_result.status,
        body: map_response_body(response_body)
      )
    end

    def handle_request_error(oauth_exception)
      error_data = JSON.parse(oauth_exception.message, symbolize_names: true)
      error_data = map_response_body(error_data)
      raise LegacyTrustCayman::RequestError, error_data
    end

    def validate_setup!
      return if oauth_client_id && oauth_client_secret

      raise LegacyTrustCayman::SetupError, 'oauth_client_id or oauth_client_secret is missing'
    end

    def map_options(opts = {})
      mapped_opts = initial_opts
      %i[params body headers].each do |key|
        next unless opts[key] || mapped_opts[key]

        option_hash = (mapped_opts[key] || {}).merge(opts[key] || {})
        mapped_opts.merge!(key => option_hash.to_camelback_keys)
      end
      mapped_opts = stringify_header_values(mapped_opts)
      mapped_opts = convert_body_to_json(mapped_opts)
      mapped_opts
    end

    def initial_headers
      {
        'content-type': 'application/json',
        'api-version': API_VERSION
      }
    end

    def initial_opts
      {
        headers: initial_headers
      }
    end

    def map_response_body(body)
      return body unless body.is_a?(Hash) || body.is_a?(Array)

      body.to_snake_keys
    end

    def stringify_header_values(mapped_opts)
      return mapped_opts unless mapped_opts[:headers]

      mapped_opts[:headers] = mapped_opts[:headers].transform_values(&:to_s)
      mapped_opts
    end

    def convert_body_to_json(mapped_opts)
      return mapped_opts unless mapped_opts[:body]

      mapped_opts[:body] = mapped_opts[:body].to_json
      mapped_opts
    end
  end
end
# rubocop:enable Metrics/ModuleLength
