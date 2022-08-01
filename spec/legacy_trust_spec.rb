# frozen_string_literal: true

RSpec.describe LegacyTrustCayman do
  it 'has a version number' do
    expect(LegacyTrustCayman::VERSION).not_to be nil
  end

  it 'has an API version' do
    expect(LegacyTrustCayman::API_VERSION).to be '1.0.0'
  end
end
