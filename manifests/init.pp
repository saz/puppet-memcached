class memcached(
  $package_ensure  = 'present',
  $logfile         = '/var/log/memcached.log',
  $max_memory      = false,
  $item_size       = false,
  $lock_memory     = false,
  $listen_ip       = '0.0.0.0',
  $tcp_port        = 11211,
  $udp_port        = 11211,
  $user            = $::memcached::params::user,
  $max_connections = '8192',
  $verbosity       = undef,
  $unix_socket     = undef,
  $install_dev     = false,
  $processorcount  = $::processorcount
) inherits memcached::params {

  if $package_ensure == 'absent' {
    $service_ensure = 'stopped'
  } else {
    $service_ensure = 'running'
  }

  package { $memcached::params::package_name:
    ensure => $package_ensure,
  }

  if $install_dev {
    package { $memcached::params::dev_package_name:
      ensure  => $package_ensure,
      require => Package[$memcached::params::package_name]
    }
  }

  firewall { "100_tcp_${tcp_port}_for_memcached":
    port   => "$tcp_port",
    proto  => 'tcp',
    action => 'accept',
  }

  firewall { "100_udp_${udp_port}_for_memcached":
    port   => "$udp_port",
    proto  => 'udp',
    action => 'accept',
  }

  file { $memcached::params::config_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($memcached::params::config_tmpl),
    require => Package[$memcached::params::package_name],
  }

  service { $memcached::params::service_name:
    ensure     => $service_ensure,
    enable     => true,
    hasrestart => true,
    hasstatus  => $memcached::params::service_hasstatus,
    subscribe  => File[$memcached::params::config_file],
  }
}
