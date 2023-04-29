# frozen_string_literal: true

require 'spec_helper'

describe 'memcached::instance', type: :define do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'with minimal params' do
        let(:title) { '3489' }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('memcached::instance::servicefile') }
        it { is_expected.to contain_service('memcached@3489.service') }
        it { is_expected.to contain_systemd__unit_file('memcached@.service') }

        context 'on selinux', if: facts[:os]['selinux']['enabled'] == true do
          it { is_expected.to contain_selinux__port('allow-memcached@3489.service') }
        end

        context 'without selinux', if: facts[:os]['family'] != 'RedHat' do
          it { is_expected.not_to contain_selinux__port('allow-memcached@3489.service') }
        end
      end

      context 'with limits' do
        let(:title) { '3489' }

        let :params do
          {
            limits: {
              LimitNOFILE: 8192
            }
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('memcached::instance::servicefile') }
        it { is_expected.to contain_service('memcached@3489.service') }
        it { is_expected.to contain_systemd__unit_file('memcached@.service') }
        it { is_expected.to contain_systemd__Service_limits('memcached@3489.service') }
      end

      context 'with overrides' do
        let(:title) { '3489' }

        let :params do
          {
            override_content: "[Service]\nEnvironment='LISTEN=-l 0.0.0.0'"
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('memcached::instance::servicefile') }
        it { is_expected.to contain_service('memcached@3489.service') }
        it { is_expected.to contain_systemd__unit_file('memcached@.service') }
        it { is_expected.to contain_systemd__dropin_file('memcached@3489.service-override.conf') }
      end
    end
  end
end
