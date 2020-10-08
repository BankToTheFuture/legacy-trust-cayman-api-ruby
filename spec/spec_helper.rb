# frozen_string_literal: true

require 'bundler/setup'
require 'legacy_trust'
require 'vcr'
require 'pry'
require 'support/shared_examples'

# Setup OAuth2 authentication credentials - config/config.yml
config_env = YAML.load_file(File.join(__dir__, '..', 'config', 'config.yml'))
LegacyTrust.oauth_client_id = config_env['OAUTH_CLIENT_ID']
LegacyTrust.oauth_client_secret = config_env['OAUTH_CLIENT_SECRET']
LegacyTrust.global_client_id = config_env['GLOBAL_CLIENT_ID']
LegacyTrust.global_service_account_id = config_env['GLOBAL_SERVICE_ACCOUNT_ID']

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true

  # Filter secrets kept in environment
  # Try to ignore common variables to not clutter cassettes
  config_env.each do |key, value|
    config.filter_sensitive_data("config_env['#{key}']") { value }
  end
end

def select_or_create_vcr_cassette(test_name:, full_test_context:)
  full_path = full_test_context.gsub('::', '/') + "/#{test_name}"
  full_path.slice!('RSpec/ExampleGroups/')
  VCR.insert_cassette(
    full_path,
    match_requests_on: [
      :method,
      VCR.request_matchers.uri_without_params('signature', 'timestamp')
    ]
  )
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each, :vcr) do |test|
    select_or_create_vcr_cassette(
      test_name: test.description, full_test_context: self.class.name
    )
  end

  config.after(:each, :vcr) do
    VCR.eject_cassette
  end
end
