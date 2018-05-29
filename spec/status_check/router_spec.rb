require 'spec_helper'

RSpec.describe StatusCheck::Router do
  describe 'successful checks' do
    let(:services_response) { [true, [{success: true, service: 'test' }]] }
    let(:router_result) { [200, {}, [JSON.dump(services_response)]] }

    it 'returns valid rack respose' do
      allow(StatusCheck).to receive(:verify).and_return(services_response)

      expect(router_response).to eq(router_response)
    end
  end

  describe 'failed checks' do
    let(:services_response) { [false, [{success: false, service: 'test' }]] }
    let(:router_result) { [503, {}, [JSON.dump(services_response)]] }

    it 'returns valid rack response' do
      allow(StatusCheck).to receive(:verify).and_return(services_response)

      expect(router_response).to eq(router_response)
    end
  end

  protected

  def router_response
    described_class.call({})
  end
end
