require 'spec_helper'

RSpec.describe StatusCheck::Configuration do
  let(:configuration) { described_class.new }

  describe '.check' do
    describe 'with built in class' do
      it 'adds check' do
        add_check(StatusCheck::Services::BlockResult)
        expect(configuration.checks['test']).to be_instance_of(StatusCheck::Services::BlockResult)
      end
    end

    describe 'with custom valid class' do
      class TestCheck
        def initialize(_)
        end

        def report_status
          {success: true}
        end
      end

      it 'adds check' do
        add_check(TestCheck)
        expect(configuration.checks['test']).to be_instance_of(TestCheck)
      end
    end

    describe 'with class that cannot be instantiated' do
      class TestCheckInvalid1
      end

      it 'reports exception' do
        expect { add_check(TestCheckInvalid1) }.to raise_error(StatusCheck::Errors::NotValidParams)
      end
    end

    describe 'with class that cannot be checked' do
      class TestCheckInvalid2
        def initialize(_)
        end
      end

      it 'reports exception' do
        expect { add_check(TestCheckInvalid2) }.to raise_error(StatusCheck::Errors::NotValidParams)
      end
    end

    protected

    def add_check(service_class)
      configuration.check('test', service: service_class, connection: -> {})
    end
  end
end