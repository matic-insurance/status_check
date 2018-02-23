require 'spec_helper'

RSpec.describe StatusCheck do
  let(:connection)        { double "DatabaseConnection", execute: true }
  let(:connection_lambda) { -> { connection } }

  it 'is configurable' do
    described_class.configure { |c| c.check(:postgresql, connection: connection_lambda) }
    expect(described_class.configuration.checks).not_to be_empty
  end
end
