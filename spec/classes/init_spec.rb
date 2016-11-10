require 'spec_helper'
describe 'memcached' do

  describe 'with manage_firewall parameter' do
    ['Debian','RedHat'].each do |osfam|
      context "on osfamily #{osfam}" do
        let(:facts) do
          { :osfamily       => osfam,
            :memorysize     => '1000 MB',
            :processorcount => '1',
          }
        end

        ['true',true].each do |value|
          context "set to #{value}" do
            let(:params) { { :manage_firewall => value } }

            it { should contain_class('memcached') }

            it { should contain_firewall('100_tcp_11211_for_memcached') }
            it { should contain_firewall('100_udp_11211_for_memcached') }
          end
        end

        ['false',false].each do |value|
          context "set to #{value}" do
            let(:params) { { :manage_firewall => value } }

            it { should contain_class('memcached') }

            it { should_not contain_firewall('100_tcp_11211_for_memcached') }
            it { should_not contain_firewall('100_udp_11211_for_memcached') }
          end
        end

        context 'set to an invalid type (array)' do
          let(:params) { { :manage_firewall => ['invalid','type'] } }

          it do
            expect {
              should contain_class('memcached')
            }.to raise_error(Puppet::Error)
          end
        end
      end
    end
  end

  let :default_params do
    {
      :package_ensure  => 'present',
      :logfile         => '/var/log/memcached.log',
      :max_memory      => false,
      :item_size       => false,
      :lock_memory     => false,
      :listen_ip       => '0.0.0.0',
      :tcp_port        => '11211',
      :udp_port        => '11211',
      :user            => 'nobody',
      :max_connections => '8192',
      :install_dev     => false,
      :processorcount  => 1,
      :use_sasl        => false,
      :large_mem_pages => false,
    }
  end

  [ {},
    {
      :package_ensure  => 'latest',
      :logfile         => '/var/log/memcached.log',
      :max_memory      => '2',
      :item_size       => false,
      :lock_memory     => true,
      :listen_ip       => '127.0.0.1',
      :tcp_port        => '11212',
      :udp_port        => '11213',
      :user            => 'somebdy',
      :max_connections => '8193',
      :verbosity       => 'vvv',
      :processorcount  => 3,
      :use_sasl        => true,
      :large_mem_pages => true,
    },
    {
      :package_ensure  => 'present',
      :logfile         => '/var/log/memcached.log',
      :max_memory      => '20%',
      :lock_memory     => false,
      :listen_ip       => '127.0.0.1',
      :tcp_port        => '11212',
      :udp_port        => '11213',
      :user            => 'somebdy',
      :max_connections => '8193',
      :verbosity       => 'vvv',
      :install_dev     => true,
      :processorcount  => 1
    },
    {
      :listen_ip       => '',
    },
    {
      :pidfile         => false,
    },
    {
      :pidfile         => '/var/log/memcached.pid',
    },
    {
      :package_ensure  => 'absent',
      :install_dev     => true
    },
    {
      :service_manage => false
    }
  ].each do |param_set|
    describe "when #{param_set == {} ? "using default" : "specifying"} class parameters" do

      let :param_hash do
        default_params.merge(param_set)
      end

      let :params do
        param_set
      end

      ['Debian'].each do |osfamily|

        let :facts do
          {
            :osfamily => osfamily,
            :memorysize => '1000 MB',
            :processorcount => '1',
          }
        end

        describe "on supported osfamily: #{osfamily}" do

          it { should compile.with_all_deps }
          it { should contain_class('memcached')}

          it { should contain_class("memcached::params") }

          it { should contain_package("memcached").with_ensure(param_hash[:package_ensure]) }

          it { should_not contain_firewall('100_tcp_11211_for_memcached') }
          it { should_not contain_firewall('100_udp_11211_for_memcached') }

          it {
            if param_hash[:install_dev]
            should contain_package("libmemcached-dev").with_ensure(param_hash[:package_ensure])
            end
          }

          it { should contain_file("/etc/memcached.conf").with(
            'owner'   => 'root',
            'group'   => 'root'
          )}

          it {
            if param_hash[:service_manage] == false
              should_not contain_service('memcached')
            elsif param_hash[:package_ensure] == 'absent'
              should contain_service("memcached").with(
                'ensure'     => 'stopped',
                'enable'     => false
              )
            else
              should contain_service("memcached").with(
                'ensure'     => 'running',
                'enable'     => true,
                'hasrestart' => true,
                'hasstatus'  => false
              )
            end
          }
        end
      end
    end
  end

  context 'On Solaris' do
    let :facts do
      {
        :osfamily => 'Solaris',
        :memorysize => '1000 MB',
        :processorcount => '1',
      }
    end

    describe 'when using default class parameters' do
      let :param_hash do
        default_params
      end

      let :params do
        {}
      end

      it { should contain_class("memcached::params") }

      it { should contain_package("memcached").with_ensure('present') }

      it { should_not contain_firewall('100_tcp_11211_for_memcached') }
      it { should_not contain_firewall('100_udp_11211_for_memcached') }

      it {
        should contain_service("memcached").with(
           'ensure'     => 'running',
           'enable'     => true,
           'hasrestart' => true,
           'hasstatus'  => false
        )
      }

      it {
        should contain_svcprop("memcached/options").with(
          'fmri'     => 'memcached:default',
          'property' => 'memcached/options',
          'value'    => '"-m" "950" "-l" "0.0.0.0" "-p" "11211" "-U" "11211" "-u" "nobody" "-c" "8192" "-t" "1"',
          'notify'   => 'Service[memcached]'
        )
      }
    end
  end

  context 'On FreeBSD' do
    let :facts do
      {
        :osfamily => 'FreeBSD',
        :memorysize => '1000 MB',
        :processorcount => '1',
      }
    end

    describe 'when using default class parameters' do
      let :param_hash do
        default_params
      end

      let :params do
        {}
      end

      it { should contain_class("memcached::params") }

      it { should contain_package("memcached").with_ensure('present') }

      it { should_not contain_firewall('100_tcp_11211_for_memcached') }
      it { should_not contain_firewall('100_udp_11211_for_memcached') }

      it {
        should contain_service("memcached").with(
           'ensure'     => 'running',
           'enable'     => true,
           'hasrestart' => true,
           'hasstatus'  => false
        )
      }

      it {
        should_not contain_svcprop("memcached/options").with(
          'fmri'     => 'memcached:default',
          'property' => 'memcached/options',
          'value'    => '"-m" "950" "-l" "0.0.0.0" "-p" "11211" "-U" "11211" "-u" "nobody" "-c" "8192" "-t" "1"',
          'notify'   => 'Service[memcached]'
        )
      }
    end
  end
end

# vim: expandtab shiftwidth=2 softtabstop=2
