require 'spec_helper'
describe 'memcached' do
  let :default_params do
    {
      package_ensure: 'present',
      logfile: '/var/log/memcached.log',
      lock_memory: false,
      listen_ip: '127.0.0.1',
      tcp_port: 11_211,
      udp_port: 11_211,
      user: 'nobody',
      max_connections: 8192,
      install_dev: false,
      processorcount: 1,
      use_sasl: false,
      use_tls: false,
      large_mem_pages: false,
      pidfile: '/var/run/memcached.pid',
      disable_cachedump: false,
      tls_verify_mode: 1
    }
  end

  describe 'with manage_firewall parameter' do
    %w[Debian RedHat FreeBSD].each do |osfam|
      context "on osfamily #{osfam}" do
        let(:facts) do
          { osfamily: osfam,
            memorysize: '1000 MB',
            processorcount: '1' }
        end

        context 'with manage_firewall set to true' do
          let(:params) { { manage_firewall: true } }

          it { is_expected.to contain_class('memcached') }

          it { is_expected.to contain_firewall('100_tcp_11211_for_memcached') }
          it { is_expected.to contain_firewall('100_udp_11211_for_memcached') }
        end

        context 'with manage_firewall set to false' do
          let(:params) { { manage_firewall: false } }

          it { is_expected.to contain_class('memcached') }

          it { is_expected.not_to contain_firewall('100_tcp_11211_for_memcached') }
          it { is_expected.not_to contain_firewall('100_udp_11211_for_memcached') }
        end

        context 'with manage_firewall set to an invalid type (array)' do
          let(:params) { { manage_firewall: %w[invalid type] } }

          it do
            expect do
              is_expected.to contain_class('memcached')
            end.to raise_error(Puppet::Error)
          end
        end
      end
    end
  end

  [{},
   {
     package_ensure: 'latest',
     logfile: '/var/log/memcached.log',
     max_memory: 2,
     lock_memory: true,
     listen_ip: '127.0.0.1',
     tcp_port: 11_212,
     udp_port: 11_213,
     user: 'somebdy',
     max_connections: 8193,
     verbosity: 'vvv',
     processorcount: 3,
     use_sasl: true,
     large_mem_pages: true,
     extended_opts: %w[lru_crawler lru_maintainer]
   },
   {
     package_ensure: 'present',
     logfile: '/var/log/memcached.log',
     max_memory: '20%',
     lock_memory: false,
     listen_ip: '127.0.0.1',
     tcp_port: 11_212,
     udp_port: 11_213,
     user: 'somebdy',
     max_connections: 8193,
     verbosity: 'vvv',
     install_dev: true,
     processorcount: 1,
     extended_opts: %w[lru_crawler lru_maintainer],
     disable_cachedump: true
   },
   {
     pidfile: '/var/log/memcached.pid',
     disable_cachedump: true
   },
   {
     package_ensure: 'absent',
     install_dev: true
   },
   {
     listen_ip: ['127.0.0.1', '127.0.0.2']
   },
   {
     use_tls: true,
     tls_cert_chain: '/path/to/cert',
     tls_key: '/path/to/key',
     tls_ca_cert: '/path/to/cacert'
   },
   {
     use_tls: true,
     tls_cert_chain: '/path/to/cert',
     tls_key: '/path/to/key'
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

      ['FreeBSD'].each do |osfamily|
        context "on osfamily #{osfamily}" do
          let(:facts) do
            { osfamily: osfamily,
              memorysize: '1000 MB',
              processorcount: '1' }
          end

          describe "on supported osfamily: #{osfamily}" do
            it { is_expected.to compile.with_all_deps }
            it { is_expected.to contain_class('memcached') }

            it { is_expected.to contain_class('memcached::params') }

            it { is_expected.not_to contain_firewall('100_tcp_11211_for_memcached') }
            it { is_expected.not_to contain_firewall('100_udp_11211_for_memcached') }

            it do
              if param_hash[:install_dev]
                is_expected.to contain_package('libmemcached').with_ensure(param_hash[:package_ensure])
              end
            end

            it do
              is_expected.to contain_file('/etc/rc.conf.d/memcached').with(
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
              flags = ['-d']
              flags.push("-u #{param_hash[:user]}")
              flags.push("-P #{param_hash[:pidfile]}") if param_hash[:pidfile]
              flags.push("-t #{param_hash[:processorcount]}")

              if param_hash[:listen_ip] != ''
                if param_hash[:listen_ip].is_a?(String)
                  flags.push("-l #{param_hash[:listen_ip]}")
                else
                  flags.push("-l #{param_hash[:listen_ip].join(',')}")
                end
              end

              flags.push('-k') if param_hash[:lock_memory]
              flags.push("-c #{param_hash[:max_connections]}")
              flags.push("-p #{param_hash[:tcp_port]}")
              flags.push("-U #{param_hash[:udp_port]}")
              flags.push('-' + param_hash[:verbosity]) if param_hash[:verbosity]

              if param_hash[:max_memory]
                if param_hash[:max_memory].is_a?(String) && param_hash[:max_memory].end_with?('%')
                  flags.push('-m 200')
                else
                  flags.push("-m #{param_hash[:max_memory]}")
                end
              else
                flags.push('-m 950')
              end

              flags.push('-S') if param_hash[:use_sasl]

              if param_hash[:use_tls]
                flags.push('-Z')
                flags.push("-o ssl_chain_cert=#{param_hash[:tls_cert_chain]}")
                flags.push("-o ssl_key=#{param_hash[:tls_key]}")
                if param_hash[:tls_ca_cert]
                  flags.push("-o ssl_ca_cert=#{param_hash[:tls_ca_cert]}")
                end
                flags.push("-o ssl_verify_mode=#{param_hash[:tls_verify_mode]}")
              end

              flags.push('-L') if param_hash[:large_mem_pages]
              flags.push('-X') if param_hash[:disable_cachedump]
              flags.push('-o lru_crawler,lru_maintainer') if param_hash[:extended_opts]

              enabled = 'YES'
              enabled = 'NO' if param_hash[:service_manage] == false

              is_expected.to contain_file('/etc/rc.conf.d/memcached').with_content(
                "### MANAGED BY PUPPET\n### DO NOT EDIT\n\nmemcached_enable=\"#{enabled}\"\nmemcached_flags=\"#{flags.join(' ')}\"\n"
      )
            end
          end
        end
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
              if param_hash[:max_memory].is_a?(String) && param_hash[:max_memory].end_with?('%')
                expected_lines.push('-m 200')
              else
                expected_lines.push("-m #{param_hash[:max_memory]}")
              end
            else
              expected_lines.push('-m 950')
            end
            if param_hash[:listen_ip] != ''
              if param_hash[:listen_ip].is_a?(String)
                expected_lines.push("-l #{param_hash[:listen_ip]}")
              else
                expected_lines.push("-l #{param_hash[:listen_ip].join(',')}")
              end
            end
            expected_lines.push('-k') if param_hash[:lock_memory]
            if param_hash[:pidfile]
              expected_lines.push("-P #{param_hash[:pidfile]}")
            end
            expected_lines.push('-vvv') if param_hash[:verbosity]
            expected_lines.push('-S') if param_hash[:use_sasl]
            if param_hash[:use_tls]
              expected_lines.push('-Z')
              expected_lines.push("-o ssl_chain_cert=#{param_hash[:tls_cert_chain]}")
              expected_lines.push("-o ssl_key=#{param_hash[:tls_key]}")
              if param_hash[:tls_ca_cert]
                expected_lines.push("-o ssl_ca_cert=#{param_hash[:tls_ca_cert]}")
              end
              expected_lines.push("-o ssl_verify_mode=#{param_hash[:tls_verify_mode]}")
            end
            expected_lines.push('-L') if param_hash[:large_mem_pages]
            expected_lines.push('-X') if param_hash[:disable_cachedump] == true
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

  context 'with osfamily = Solaris' do
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
          'value'    => '"-m" "950" "-l" "127.0.0.1" "-p" "11211" "-U" "11211" "-u" "nobody" "-c" "8192" "-t" "1"',
          'notify'   => 'Service[memcached]'
        )
      end
    end
  end

  context 'with osfamily = FreeBSD' do
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

      it do
        is_expected.not_to contain_svcprop('memcached/options').with(
          'fmri'     => 'memcached:default',
          'property' => 'memcached/options',
          'value'    => '"-m" "950" "-l" "127.0.0.1" "-p" "11211" "-U" "11211" "-u" "nobody" "-c" "8192" "-t" "1"',
          'notify'   => 'Service[memcached]'
        )
      end
    end
  end
  context 'with osfamily = Redhat' do
    let :facts do
      {
        osfamily: 'RedHat',
        memorysize: '1000 MB',
        processorcount: '4'
      }
    end

    describe 'when listen_ip is an array' do
      let :custom_params do
        {
          'listen_ip' => ['127.0.0.1', '127.0.0.2']
        }
      end

      let :param_hash do
        default_params.merge(custom_params)
      end

      let :params do
        custom_params
      end

      it do
        is_expected.to contain_file('/etc/sysconfig/memcached').with_content(
          "PORT=\"11211\"\nUSER=\"memcached\"\nMAXCONN=\"8192\"\nCACHESIZE=\"950\"\nOPTIONS=\"-l 127.0.0.1,127.0.0.2 -U 11211 -t 4 >> /var/log/memcached.log 2>&1\"\n"
        )
      end
    end

    describe 'when using custom class parameters' do
      let :custom_params do
        {
          'disable_cachedump' => true
        }
      end

      let :param_hash do
        default_params.merge(custom_params)
      end

      let :params do
        custom_params
      end

      it do
        is_expected.to contain_file('/etc/sysconfig/memcached').with_content(
          "PORT=\"11211\"\nUSER=\"memcached\"\nMAXCONN=\"8192\"\nCACHESIZE=\"950\"\nOPTIONS=\"-l 127.0.0.1 -U 11211 -X -t 4 >> /var/log/memcached.log 2>&1\"\n"
        )
      end
    end

    describe 'when setting logstdout to true' do
      let :custom_params do
        {
          'logstdout' => true
        }
      end

      let :param_hash do
        default_params.merge(custom_params)
      end

      let :params do
        custom_params
      end

      it do
        is_expected.to contain_file('/etc/sysconfig/memcached').with_content(
          "PORT=\"11211\"\nUSER=\"memcached\"\nMAXCONN=\"8192\"\nCACHESIZE=\"950\"\nOPTIONS=\"-l 127.0.0.1 -U 11211 -t 4\"\n"
        )
      end
    end

    describe 'when setting use_tls to true' do
      let :custom_params do
        {
          'use_tls'         => true,
          'tls_cert_chain'  => '/path/to/cert',
          'tls_key'         => '/path/to/key',
          'tls_ca_cert'     => '/path/to/cacert',
          'tls_verify_mode' => 0
        }
      end

      let :param_hash do
        default_params.merge(custom_params)
      end

      let :params do
        custom_params
      end

      it do
        is_expected.to contain_file('/etc/sysconfig/memcached').with_content(
          "PORT=\"11211\"\nUSER=\"memcached\"\nMAXCONN=\"8192\"\nCACHESIZE=\"950\"\nOPTIONS=\"-l 127.0.0.1 -U 11211 -t 4 -Z -o ssl_chain_cert=/path/to/cert -o ssl_key=/path/to/key -o ssl_ca_cert=/path/to/cacert -o ssl_verify_mode=0 >> /var/log/memcached.log 2>&1\"\n"
        )
      end
    end

    describe 'when setting use_tls to true and unset tls_ca_cert' do
      let :custom_params do
        {
          'use_tls'        => true,
          'tls_cert_chain' => '/path/to/cert',
          'tls_key'        => '/path/to/key'
        }
      end

      let :param_hash do
        default_params.merge(custom_params)
      end

      let :params do
        custom_params
      end

      it do
        is_expected.to contain_file('/etc/sysconfig/memcached').with_content(
          "PORT=\"11211\"\nUSER=\"memcached\"\nMAXCONN=\"8192\"\nCACHESIZE=\"950\"\nOPTIONS=\"-l 127.0.0.1 -U 11211 -t 4 -Z -o ssl_chain_cert=/path/to/cert -o ssl_key=/path/to/key -o ssl_verify_mode=1 >> /var/log/memcached.log 2>&1\"\n"
        )
      end
    end
  end
end
# vim: expandtab shiftwidth=2 softtabstop=2
