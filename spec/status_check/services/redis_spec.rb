require 'spec_helper'

RSpec.describe StatusCheck::Services::Redis do
  let(:redis) { double('Redis') }
  let(:connection) { -> { redis } }

  describe 'successful result' do
    before { allow(redis).to receive(:get).and_return([nil, '3'].sample) }

    it 'returns success' do
      expect(service_response).to eq([true, 'OK'])
    end
  end

  describe 'exception' do
    before { allow(redis).to receive(:get).and_raise('eeee') }

    it 'returns fail with exception' do
      expect(service_response).to eq([false, 'eeee'])
    end
  end

  protected

  def service_response
    described_class.new(connection).report_status
  end
end
