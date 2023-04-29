# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'memcached' do
  context 'with all defaults' do
    let :pp1 do
      <<-PUPPET
      memcached::instance{'11222':}
      memcached::instance{'11223':}
      PUPPET
    end

    it 'works idempotently with no errors' do
      apply_manifest(pp1, catch_failures: true)
      apply_manifest(pp1, catch_changes: true)
    end

    describe service('memcached'), :default do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe service('memcached@11222'), :memcached11222 do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe service('memcached@11223'), :memcached11223 do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(11_222), :port11222 do
      it { is_expected.to be_listening.on('127.0.0.1').with('tcp') }
      it { is_expected.not_to be_listening.on('127.0.0.1').with('udp') }
    end

    describe port(11_223), :port11223 do
      it { is_expected.to be_listening.on('127.0.0.1').with('tcp') }
      it { is_expected.not_to be_listening.on('127.0.0.1').with('udp') }
    end
  end

  context 'with service limits' do
    let :pp2 do
      <<-PUPPET
      memcached::instance{'11222':
        limits => {
          'LimitNOFILE' => 8192,
          'LimitNPROC'  => 16384,
        }
      }
      PUPPET
    end

    it 'works idempotently with no errors' do
      apply_manifest(pp2, catch_failures: true)
      apply_manifest(pp2, catch_changes: true)
    end

    describe service('memcached@11222') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(11_222) do
      it { is_expected.to be_listening.on('127.0.0.1').with('tcp') }
      it { is_expected.not_to be_listening.on('127.0.0.1').with('udp') }
    end

    describe file('/etc/systemd/system/memcached@11222.service.d/90-limits.conf') do
      its(:content) { is_expected.to match %r{LimitNOFILE=8192\nLimitNPROC=16384} }
    end
  end

  context 'with LISTEN override' do
    let :pp3 do
      <<-PUPPET
      memcached::instance{'11222':
        override_content => "[Service]\nEnvironment='LISTEN=-l 0.0.0.0'\n",
      }
      PUPPET
    end

    it 'works idempotently with no errors' do
      apply_manifest(pp3, catch_failures: true)
      apply_manifest(pp3, catch_changes: true)
    end

    describe service('memcached@11222') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(11_222) do
      it { is_expected.to be_listening.on('0.0.0.0').with('tcp') }
      it { is_expected.not_to be_listening.on('0.0.0.0').with('udp') }
    end

    describe file('/etc/systemd/system/memcached@11222.service.d/memcached@11222.service-override.conf') do
      its(:content) { is_expected.to match %r{Environment='LISTEN=-l 0.0.0.0'} }
    end
  end
end
