# == Class: memcached
#
# Manage memcached
#
class memcached (
  $package_ensure  = 'present',
  $logfile         = '/var/log/memcached.log',
  $pidfile         = '/var/run/memcached.pid',
  $manage_firewall = false,
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
  $processorcount  = $::processorcount,
  $service_restart = true,
  $auto_removal    = false,
  $use_sasl        = false,
  $large_mem_pages = false,
) inherits memcached::params {

  # validate type and convert string to boolean if necessary
  if is_string($manage_firewall) {
    $manage_firewall_bool = str2bool($manage_firewall)
  } else {
    $manage_firewall_bool = $manage_firewall
  }
  validate_bool($manage_firewall_bool)
  validate_bool($service_restart)

  if $package_ensure == 'absent' {
    $service_ensure = 'stopped'
    $service_enable = false
  } else {
    $service_ensure = 'running'
    $service_enable = true
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

  if $manage_firewall_bool == true {
    firewall { "100_tcp_${tcp_port}_for_memcached":
      port   => $tcp_port,
      proto  => 'tcp',
      action => 'accept',
    }

    firewall { "100_udp_${udp_port}_for_memcached":
      port   => $udp_port,
      proto  => 'udp',
      action => 'accept',
    }
  }

  if $service_restart {
    $service_notify_real = Service[$memcached::params::service_name]
  } else {
    $service_notify_real = undef
  }

  file { $memcached::params::config_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($memcached::params::config_tmpl),
    require => Package[$memcached::params::package_name],
    notify  => $service_notify_real,
  }

  service { $memcached::params::service_name:
    ensure     => $service_ensure,
    enable     => $service_enable,
    hasrestart => true,
    hasstatus  => $memcached::params::service_hasstatus,
  }
}
