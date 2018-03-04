require 'spec_helper'

RSpec.describe StatusCheck::Runner do
  let(:service) { instance_double(StatusCheck::Services::BlockResult) }
  let(:checks) { {'test' => service} }

  describe 'successful check' do
    before { allow(service).to receive(:report_status).and_return([true, 'Good']) }

    it 'returns success' do
      expect(runner_response).to eq([true, [{service: 'test', success: true, status: 'Good'}]])
    end
  end

  describe 'false result' do
    before { allow(service).to receive(:report_status).and_return([false, 'Not Good']) }

    it 'returns fail with message' do
      expect(runner_response).to eq([false, [{service: 'test', success: false, status: 'Not Good'}]])
    end
  end

  describe 'exception' do
    before { allow(service).to receive(:report_status).and_raise('eeee') }

    it 'returns fail with exception' do
      expect(runner_response).to eq([false, [{service: 'test', success: false, status: 'eeee'}]])
    end
  end

  protected

  def runner_response
    described_class.new(checks).verify
  end
end
