require 'spec_helper'

RSpec.describe StatusCheck do
  let(:service) { StatusCheck::Services::BlockResult }
  let(:connection) { -> { true } }

  before { described_class.configuration.checks = {} }

  it 'is configurable' do
    described_class.configure { |c| c.check(:test, service: service, connection: connection) }
    expect(described_class.configuration.checks).not_to be_empty
  end

  it 'is runnable' do
    described_class.configure { |c| c.check(:test, service: service, connection: connection) }
    expect(described_class.verify).to eq([true, [{service: :test, success: true, status: 'OK'}]])
  end
end
