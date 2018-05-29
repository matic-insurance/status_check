require 'spec_helper'

RSpec.describe StatusCheck::Services::BlockResult do
  describe 'successful result' do
    let(:status_block) { -> { true } }

    it 'returns success' do
      expect(service_response(status_block)).to eq([true, 'OK'])
    end
  end

  describe 'false result' do
    let(:status_block) { -> { false } }

    it 'returns fail with default message' do
      expect(service_response(status_block)).to eq([false, 'FAILED'])
    end
  end

  describe 'exception' do
    let(:status_block) { -> { raise 'eeee' } }

    it 'returns fail with exception' do
      expect(service_response(status_block)).to eq([false, 'eeee'])
    end
  end

  protected

  def service_response(status_block)
    described_class.new(status_block).report_status
  end
end
