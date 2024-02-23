# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'legacy_trust_cayman/version'

Gem::Specification.new do |spec|
  spec.name          = 'legacy-trust-cayman-api'
  spec.version       = LegacyTrustCayman::VERSION
  spec.authors       = ['Pawel Slowik', 'Mateusz Wilczynski', 'Pawel Stracala']
  spec.email         = ['info@banktothefuture.com']

  spec.summary       = 'LegacyTrustCayman API wrapper for Ruby'
  spec.description   = 'LegacyTrustCayman API wrapper for Ruby'
  spec.homepage      = 'https://bnktothefuture.com'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/BankToTheFuture/legacy-trust-cayman-api-ruby'
  spec.metadata['changelog_uri'] = 'https://github.com/BankToTheFuture/legacy-trust-cayman-api-ruby/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6'

  spec.add_dependency 'awrence'
  spec.add_dependency 'oauth2'
  spec.add_dependency 'plissken'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
