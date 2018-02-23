require 'spec_helper'

RSpec.describe StatusCheck::Router do
  let(:check_response) { [{success: true, service: "postgresq" }] }
  let(:valid_response) { [200, {}, [JSON.dump(check_response)]] }

  it 'is returns valid rack respose' do
    expect(StatusCheck::Services)
      .to receive(:check_all)
      .and_return(check_response)

    expect(described_class.call({})).to eq(valid_response)
  end
end
