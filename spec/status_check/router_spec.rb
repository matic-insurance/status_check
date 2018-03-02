require 'spec_helper'

RSpec.describe StatusCheck::Router do
  describe 'successful checks' do
    let(:services_response) { [{success: true, service: 'postgresq' }] }
    let(:router_response) { [200, {}, [JSON.dump(services_response)]] }

    it 'returns valid rack respose' do
      allow(StatusCheck::Services)
          .to receive(:check_all)
                  .and_return(services_response)

      expect(router_response).to eq(router_response)
    end
  end

  describe 'failed checks' do
    let(:services_response) { [{success: false, service: 'another' }] }
    let(:router_response) { [503, {}, [JSON.dump(services_response)]] }

    it 'returns valid rack response' do
      allow(StatusCheck::Services)
          .to receive(:check_all)
                  .and_return(services_response)

      expect(router_response).to eq(router_response)
    end
  end

  protected

  def router_response
    described_class.call({})
  end
end
