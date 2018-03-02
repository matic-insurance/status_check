require 'spec_helper'

RSpec.describe StatusCheck::Services do
  let(:connection)        { double "DatabaseConnection", execute: true }
  let(:connection_lambda) { -> { connection } }
  let(:service_params)    { { name: :postgresql, connection: connection_lambda } }

  it 'can service name to service class' do
    expect(described_class::SERVICES_MAP.keys)
      .to eq([:postgresql, :redis])
  end

  describe "set up service for checking" do
    it 'succeed with valid params' do
      expect(described_class.setup(service_params))
        .to be_a(described_class::Postgresql)
    end

    it 'fails with invalid params' do
      expect{described_class.setup({})}
        .to raise_error(StatusCheck::Errors::MissingParams)
    end
  end
end
