require 'spec_helper'

RSpec.describe StatusCheck::Services::Abstract do
  class TestService < StatusCheck::Services::Abstract
    def command
      connection.call
    end
  end

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

  describe 'low level error' do
    let(:status_block) { -> { raise NoMemoryError.new('test') } }

    it 'raises exception' do
      begin
        service_response(status_block)
        expect('not to raise error').to be_falsey
      rescue NoMemoryError => _
        expect('to raise error').to be_truthy
      end
    end
  end

  protected

  def service_response(status_block)
    TestService.new(status_block).report_status
  end
end
