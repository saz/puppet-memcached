require 'spec_helper'
describe 'memcached' do

  let :default_params do
    {
      :package_ensure  => 'present',
      :logfile         => '/var/log/memcached.log',
      :max_memory      => false,
      :lock_memory     => false,
      :listen_ip       => '0.0.0.0',
      :tcp_port        => '11211',
      :udp_port        => '11211',
      :user            => 'nobody',
      :max_connections => '8192'
    }
  end

  [ {},
    {
      :package_ensure  => 'latest',
      :logfile         => '/var/log/memcached.log',
      :max_memory      => '2',
      :lock_memory     => true,
      :listen_ip       => '127.0.0.1',
      :tcp_port        => '11212',
      :udp_port        => '11213',
      :user            => 'somebdy',
      :max_connections => '8193',
      :verbosity       => 'vvv'
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
      :verbosity       => 'vvv'
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

          it { should contain_class('memcached::params') }

          it { should contain_package('memcached').with_ensure(param_hash[:package_ensure]) }

          it { should contain_file('/etc/memcached.conf').with(
            'owner'   => 'root',
            'group'   => 'root'
          )}

          it { should contain_service('memcached').with(
            'ensure'     => 'running',
            'enable'     => true,
            'hasrestart' => true,
            'hasstatus'  => false
          )}

          it 'should compile the template based on the class parameters' do
            content = param_value(
              subject,
              'file',
              '/etc/memcached.conf',
              'content'
            )
            expected_lines = [
              "logfile #{param_hash[:logfile]}",
              "-l #{param_hash[:listen_ip]}",
              "-p #{param_hash[:tcp_port]}",
              "-U #{param_hash[:udp_port]}",
              "-u #{param_hash[:user]}",
              "-c #{param_hash[:max_connections]}",
              "-t #{facts[:processorcount]}"
            ]
            if(param_hash[:max_memory])
              if(param_hash[:max_memory].end_with?('%'))
                expected_lines.push("-m 200")
              else
                expected_lines.push("-m #{param_hash[:max_memory]}")
              end
            else
              expected_lines.push("-m 950")
            end
            if(param_hash[:lock_memory])
              expected_lines.push("-k")
            end
            if(param_hash[:verbosity])
              expected_lines.push("-vvv")
            end
            (content.split("\n") & expected_lines).should =~ expected_lines
          end
        end
      end
      ['Redhat'].each do |osfamily|
        describe 'on supported platform' do
          it 'should fail' do

          end
        end
      end
    end
  end
end
