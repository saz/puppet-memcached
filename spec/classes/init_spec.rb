# frozen_string_literal: true

require 'spec_helper'

describe 'memcached' do
  let :node do
    'rspec.puppet.com'
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'with all defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('memcached::params') }
        it { is_expected.to contain_service('memcached').with_ensure('running').with_enable('true') }
        it { is_expected.to contain_package('memcached').with_ensure('present') }
        it { is_expected.not_to contain_firewall('100_tcp_11211_for_memcached') }
        it { is_expected.not_to contain_firewall('100_udp_11211_for_memcached') }

        context 'on RedHat', if: facts[:os]['family'] == 'RedHat' do
          it { is_expected.to contain_file('/etc/sysconfig/memcached').with_ensure('file') }
        end

        context 'on Debian', if: facts[:os]['family'] == 'Debian' do
          it { is_expected.to contain_file('/etc/memcached.conf').with_ensure('file') }
        end
      end

      describe 'with manage_firewall parameter' do
        context 'with manage_firewall set to true and unset udp_port' do
          let(:params) { { manage_firewall: true } }

          it { is_expected.to contain_class('memcached') }

          it { is_expected.to contain_firewall('100_tcp_11211_for_memcached') }
        end

        context 'with manage_firewall set to true and udp_port set to 11211' do
          let :params do
            {
              'manage_firewall' => true,
              'udp_port'        => 11_211
            }
          end

          it { is_expected.to contain_class('memcached') }

          it { is_expected.to contain_firewall('100_tcp_11211_for_memcached') }
          it { is_expected.to contain_firewall('100_udp_11211_for_memcached') }
        end
      end

      describe 'when setting use_tls to true and unset tls_ca_cert' do
        let :params do
          {
            'processorcount'  => 1,
            'use_tls'         => true,
            'tls_cert_chain'  => '/path/to/cert',
            'tls_key'         => '/path/to/key',
            'tls_ca_cert'     => '/path/to/cacert',
            'tls_verify_mode' => 0
          }
        end

        context 'on RedHat', if: facts[:os]['family'] == 'RedHat' do
          it { is_expected.to contain_file('/etc/sysconfig/memcached').with_content(%r{^OPTIONS="-l 127.0.0.1 -U 0 -t 1 -Z -o ssl_chain_cert=/path/to/cert -o ssl_key=/path/to/key -o ssl_ca_cert=/path/to/cacert -o ssl_verify_mode=0 >> /var/log/memcached.log 2>&1"$}) }
        end
      end

      describe 'when both listen and listen_ip parameters are not set' do
        context 'on RedHat', if: facts[:os]['family'] == 'RedHat' do
          it { is_expected.to contain_file('/etc/sysconfig/memcached').with_content(%r{^OPTIONS="-l 127.0.0.1 }) }
        end

        context 'on Debian', if: facts[:os]['family'] == 'Debian' do
          it { is_expected.to contain_file('/etc/memcached.conf').with_content(%r{^-l 127.0.0.1$}) }
        end
      end

      describe 'when setting listen parameter to a string' do
        let :params do
          {
            'listen' => '127.0.1.1',
          }
        end

        context 'on RedHat', if: facts[:os]['family'] == 'RedHat' do
          it { is_expected.to contain_file('/etc/sysconfig/memcached').with_content(%r{^OPTIONS="-l 127.0.1.1 }) }
        end

        context 'on Debian', if: facts[:os]['family'] == 'Debian' do
          it { is_expected.to contain_file('/etc/memcached.conf').with_content(%r{^-l 127.0.1.1$}) }
        end
      end

      describe 'when setting listen parameter to an array with a single string' do
        let :params do
          {
            'listen' => ['127.0.2.1'],
          }
        end

        context 'on RedHat', if: facts[:os]['family'] == 'RedHat' do
          it { is_expected.to contain_file('/etc/sysconfig/memcached').with_content(%r{^OPTIONS="-l 127.0.2.1 }) }
        end

        context 'on Debian', if: facts[:os]['family'] == 'Debian' do
          it { is_expected.to contain_file('/etc/memcached.conf').with_content(%r{^-l 127.0.2.1$}) }
        end
      end

      describe 'when setting listen parameter to an array of strings' do
        let :params do
          {
            'listen' => ['127.0.3.1', '127.0.3.2'],
          }
        end

        context 'on RedHat', if: facts[:os]['family'] == 'RedHat' do
          it { is_expected.to contain_file('/etc/sysconfig/memcached').with_content(%r{^OPTIONS="-l 127.0.3.1,127.0.3.2 }) }
        end

        context 'on Debian', if: facts[:os]['family'] == 'Debian' do
          it { is_expected.to contain_file('/etc/memcached.conf').with_content(%r{^-l 127.0.3.1,127.0.3.2$}) }
        end
      end
    end
  end
end
# vim: expandtab shiftwidth=2 softtabstop=2
