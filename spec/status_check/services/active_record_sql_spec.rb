require 'spec_helper'

RSpec.describe StatusCheck::Services::ActiveRecordSql do
  let(:db) { double('db connection') }
  let(:connection) { -> { db } }

  describe 'successful result' do
    before { allow(db).to receive(:execute).and_return([nil, '3'].sample) }

    it 'returns success' do
      expect(service_response).to eq([true, 'OK'])
    end
  end

  describe 'exception' do
    before { allow(db).to receive(:execute).and_raise('eeee') }

    it 'returns fail with exception' do
      expect(service_response).to eq([false, 'eeee'])
    end
  end

  protected

  def service_response
    described_class.new(connection).report_status
  end
end
