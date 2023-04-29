# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'memcached' do
  context 'with all defaults' do
    let(:pp) do
      'include memcached'
    end

    it 'works idempotently with no errors' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe service('memcached') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(11_211) do
      it { is_expected.to be_listening.on('127.0.0.1').with('tcp') }
      it { is_expected.not_to be_listening.on('127.0.0.1').with('udp') }
    end
  end
end
