require 'spec_helper'
describe 'memcached' do
  describe 'with manage_firewall parameter' do
    %w(Debian RedHat).each do |osfam|
      context "on osfamily #{osfam}" do
        let(:facts) do
          { osfamily: osfam,
            memorysize: '1000 MB',
            processorcount: '1' }
        end

        ['true', true].each do |value|
          context "set to #{value}" do
            let(:params) { { manage_firewall: value } }

            it { is_expected.to contain_class('memcached') }

            it { is_expected.to contain_firewall('100_tcp_11211_for_memcached') }
            it { is_expected.to contain_firewall('100_udp_11211_for_memcached') }
          end
        end

        ['false', false].each do |value|
          context "set to #{value}" do
            let(:params) { { manage_firewall: value } }

            it { is_expected.to contain_class('memcached') }

            it { is_expected.not_to contain_firewall('100_tcp_11211_for_memcached') }
            it { is_expected.not_to contain_firewall('100_udp_11211_for_memcached') }
          end
        end

        context 'set to an invalid type (array)' do
          let(:params) { { manage_firewall: %w(invalid type) } }

          it do
            expect do
              is_expected.to contain_class('memcached')
            end.to raise_error(Puppet::Error)
          end
        end
      end
    end
  end

  let :default_params do
    {
      package_ensure: 'present',
      logfile: '/var/log/memcached.log',
      max_memory: false,
      max_item_size: false,
      min_item_size: false,
      lock_memory: false,
      listen_ip: '127.0.0.1',
      tcp_port: '11211',
      udp_port: '11211',
      user: 'nobody',
      max_connections: '8192',
      install_dev: false,
      processorcount: 1,
      use_sasl: false,
      large_mem_pages: false,
      pidfile: '/var/run/memcached.pid'
    }
  end

  [{},
   {
     package_ensure: 'latest',
     logfile: '/var/log/memcached.log',
     max_memory: '2',
     max_item_size: false,
     min_item_size: false,
     lock_memory: true,
     listen_ip: '127.0.0.1',
     tcp_port: '11212',
     udp_port: '11213',
     user: 'somebdy',
     max_connections: '8193',
     verbosity: 'vvv',
     processorcount: 3,
     use_sasl: true,
     large_mem_pages: true,
     extended_opts: %w(lru_crawler lru_maintainer)
   },
   {
     package_ensure: 'present',
     logfile: '/var/log/memcached.log',
     max_memory: '20%',
     lock_memory: false,
     listen_ip: '127.0.0.1',
     tcp_port: '11212',
     udp_port: '11213',
     user: 'somebdy',
     max_connections: '8193',
     verbosity: 'vvv',
     install_dev: true,
     processorcount: 1,
     extended_opts: %w(lru_crawler lru_maintainer)
   },
   {
     listen_ip: ''
   },
   {
     pidfile: false
   },
   {
     pidfile: '/var/log/memcached.pid'
   },
   {
     package_ensure: 'absent',
     install_dev: true
   },
   {
     service_manage: false
   }].each do |param_set|
    describe "when #{param_set == {} ? 'using default' : 'specifying'} class parameters" do
      let :param_hash do
        default_params.merge(param_set)
      end

      let :params do
        param_set
      end

      ['Debian'].each do |osfamily|
        let :facts do
          {
            osfamily: osfamily,
            memorysize: '1000 MB',
            processorcount: '1'
          }
        end

        describe "on supported osfamily: #{osfamily}" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('memcached') }

          it { is_expected.to contain_class('memcached::params') }

          it { is_expected.to contain_package('memcached').with_ensure(param_hash[:package_ensure]) }

          it { is_expected.not_to contain_firewall('100_tcp_11211_for_memcached') }
          it { is_expected.not_to contain_firewall('100_udp_11211_for_memcached') }

          it do
            if param_hash[:install_dev]
              is_expected.to contain_package('libmemcached-dev').with_ensure(param_hash[:package_ensure])
            end
          end

          it do
            is_expected.to contain_file('/etc/memcached.conf').with(
              'owner'   => 'root',
              'group'   => 0
          )
          end

          it do
            if param_hash[:service_manage] == false
              is_expected.not_to contain_service('memcached')
            elsif param_hash[:package_ensure] == 'absent'
              is_expected.to contain_service('memcached').with(
                'ensure'     => 'stopped',
                'enable'     => false
              )
            else
              is_expected.to contain_service('memcached').with(
                'ensure'     => 'running',
                'enable'     => true,
                'hasrestart' => true,
                'hasstatus'  => false
              )
            end
          end

          it 'compiles the template based on the class parameters' do
            content = param_value(
              catalogue,
              'file',
              '/etc/memcached.conf',
              'content'
            )
            expected_lines = [
              "logfile #{param_hash[:logfile]}",
              "-p #{param_hash[:tcp_port]}",
              "-U #{param_hash[:udp_port]}",
              "-u #{param_hash[:user]}",
              "-c #{param_hash[:max_connections]}",
              "-t #{param_hash[:processorcount]}"
            ]
            if param_hash[:max_memory]
              if param_hash[:max_memory].end_with?('%')
                expected_lines.push('-m 200')
              else
                expected_lines.push("-m #{param_hash[:max_memory]}")
              end
            else
              expected_lines.push('-m 950')
            end
            if param_hash[:listen_ip] != ''
              expected_lines.push("-l #{param_hash[:listen_ip]}")
            end
            expected_lines.push('-k') if param_hash[:lock_memory]
            if param_hash[:pidfile]
              expected_lines.push("-P #{param_hash[:pidfile]}")
            end
            expected_lines.push('-vvv') if param_hash[:verbosity]
            expected_lines.push('-S') if param_hash[:use_sasl]
            expected_lines.push('-L') if param_hash[:large_mem_pages]
            if param_hash[:extended_opts]
              expected_lines.push('-o lru_crawler,lru_maintainer')
            end
            (content.split("\n") & expected_lines).should =~ expected_lines
          end
        end
      end
      ['Redhat'].each do |_osfamily|
        describe 'on supported platform' do
          it 'fails' do
          end
        end
      end
    end
  end

  context 'On Solaris' do
    let :facts do
      {
        osfamily: 'Solaris',
        memorysize: '1000 MB',
        processorcount: '1'
      }
    end

    describe 'when using default class parameters' do
      let :param_hash do
        default_params
      end

      let :params do
        {}
      end

      it { is_expected.to contain_class('memcached::params') }

      it { is_expected.to contain_package('memcached').with_ensure('present') }

      it { is_expected.not_to contain_firewall('100_tcp_11211_for_memcached') }
      it { is_expected.not_to contain_firewall('100_udp_11211_for_memcached') }

      it do
        is_expected.to contain_service('memcached').with(
          'ensure'     => 'running',
          'enable'     => true,
          'hasrestart' => true,
          'hasstatus'  => false
        )
      end

      it do
        is_expected.to contain_svcprop('memcached/options').with(
          'fmri'     => 'memcached:default',
          'property' => 'memcached/options',
          'value'    => "\"-m\" \"950\" \"-l\" \"127.0.0.1\" \"-p\" \"11211\" \"-U\" \"11211\" \"-u\" \"nobody\" \"-c\" \"8192\" \"-t\" \"1\"\n",
          'notify'   => 'Service[memcached]'
        )
      end
    end
  end

  context 'On FreeBSD' do
    let :facts do
      {
        osfamily: 'FreeBSD',
        memorysize: '1000 MB',
        processorcount: '2'
      }
    end

    describe 'when using default class parameters' do
      let :params do
        default_params
      end

      it { is_expected.to contain_class('memcached::params') }

      it { is_expected.to contain_package('memcached').with_ensure('present') }

      it { is_expected.not_to contain_firewall('100_tcp_11211_for_memcached') }
      it { is_expected.not_to contain_firewall('100_udp_11211_for_memcached') }

      it do
        is_expected.to contain_service('memcached').with(
          'ensure'     => 'running',
          'enable'     => true,
          'hasrestart' => true,
          'hasstatus'  => false
        )
      end

      it do
        is_expected.to contain_file('/etc/rc.conf.d/memcached').with_content(
          "### MANAGED BY PUPPET\n### DO NOT EDIT\n\n\memcached_enable=\"YES\"\nmemcached_flags=\"-d -u nobody -P /var/run/memcached.pid -t 1 -l 127.0.0.1 -c 8192 -p 11211 -U 11211\"\n"
        )
      end

      it do
        is_expected.not_to contain_svcprop('memcached/options').with(
          'fmri'     => 'memcached:default',
          'property' => 'memcached/options',
          'value'    => '"-m" "950" "-l" "127.0.0.1" "-p" "11211" "-U" "11211" "-u" "nobody" "-c" "8192" "-t" "1"',
          'notify'   => 'Service[memcached]'
        )
      end
    end

    describe 'when using custom class parameters' do
      let :custom_params do
        {
          'listen_ip' => '127.0.0.1',
          'tcp_port'  => '9999',
          'udp_port'  => '9999'
        }
      end

      let :param_hash do
        default_params.merge(custom_params)
      end

      let :params do
        custom_params
      end

      # TODO: figure out how to check the file contents
      it do
        is_expected.to contain_file('/etc/rc.conf.d/memcached').with_content(
          "### MANAGED BY PUPPET\n### DO NOT EDIT\n\n\memcached_enable=\"YES\"\nmemcached_flags=\"-d -u nobody -P /var/run/memcached.pid -t 2 -l 127.0.0.1 -c 8192 -p 9999 -U 9999\"\n"
        )
      end
    end
  end
end
# vim: expandtab shiftwidth=2 softtabstop=2
