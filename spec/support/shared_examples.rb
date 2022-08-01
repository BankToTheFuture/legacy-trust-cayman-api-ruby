# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_examples_for 'invalid API setup' do
  before { allow(LegacyTrustCayman).to receive(:oauth_client_id).and_return(nil) }

  it 'raises error' do
    expect { method_execution }.to raise_error(LegacyTrustCayman::SetupError)
  end
end
