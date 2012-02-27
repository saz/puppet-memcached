class memcached::params {

  $package_ensure = $::memcached_package_ensure ? {
    ''      => 'present',
    default => $::memcached_package_ensure
  }

  $logfile = $::memcached_logfile ? {
    ''      => '/var/log/memcached.log',
    default => $::memcached_logfile
  }

  $max_memory = $::memcached_max_memory ? {
    ''      => false,
    default => $::memcached_max_memory
  }

  $listen_ip = $::memcached_listen_ip ? {
    ''      => '0.0.0.0',
    default => $::memcached_listen_ip
  }

  $tcp_port = $::memcached_tcp_port ? {
    ''      => 11211,
    default => $::memcached_tcp_port
  }

  $udp_port = $::memcached_udp_port ? {
    ''      => 11211,
    default => $::memcached_udp_port
  }

  $max_connections = $::memcached_max_connections ? {
    ''      => 8192,
    default => $::memcached_max_connections
  }

  $package_name = $::memcached_package_name ? {
    ''      => 'memcached',
    default => $::memcached_package_name
  }

  $service_name = $::memcached_service_name ? {
    ''      => 'memcached',
    default => $::memcached_service_name
  }

  $config_file = $::memcached_config_file ? {
    ''      => $::operatingsystem ? {
      'ubuntu' => '/etc/memcached.conf',
      'debian' => '/etc/memcached.conf',
      'centos' => '/etc/sysconfig/memcached',
      'redhat' => '/etc/sysconfig/memcached',
      default  => undef #undef is not very nice here, but since the memcached
                        #module implements an OS check, it's acceptable for now
    },
    default => $::memcached_config_file
  }

  $config_tmpl = $::memcached_config_tmpl ? {
    ''      => $::operatingsystem ? {
      'ubuntu' => "${module_name}/memcached.conf.erb",
      'debian' => "${module_name}/memcached.conf.erb",
      'centos' => "${module_name}/memcached_sysconfig.erb",
      'redhat' => "${module_name}/memcached_sysconfig.erb",
      default  => undef #undef is not very nice here, but since the memcached
                        #module implements an OS check, it's acceptable for now
    },
    default => $::memcached_config_tmpl
  }

  $user = $::memcached_user ? {
    ''      => $::operatingsystem ? {
      'ubuntu' => 'nobody',
      'debian' => 'nobody',
      'centos' => 'memcached',
      'redhat' => 'memcached',
      default  => undef
    },
    default => $::memcached_user
  }
}
