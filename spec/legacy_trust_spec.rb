# frozen_string_literal: true

RSpec.describe LegacyTrust do
  it 'has a version number' do
    expect(LegacyTrust::VERSION).not_to be nil
  end

  it 'has an API version' do
    expect(LegacyTrust::API_VERSION).to be '1.0.0'
  end
end
