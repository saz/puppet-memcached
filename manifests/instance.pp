# == Type: memcached::instance
#
# Manage memcached instances
#
define memcached::instance (
  $package_ensure   = 'present',
  $manage_firewall  = false,
  $max_memory       = false,
  $item_size        = false,
  $lock_memory      = false,
  $listen_ip        = '0.0.0.0',
  $tcp_port         = 11211,
  $udp_port         = 11211,
  $max_connections  = '8192',
  $verbosity        = undef,
  $unix_socket      = undef,
  $install_dev      = false,
  $processorcount   = $::processorcount,
  $service_restart  = true,
  $auto_removal     = false,
  $use_sasl         = false,
  $large_mem_pages  = false,
  $service_ensure   = 'running',
  $service_enable   = true
) {

  include ::memcached::params

  # validate type and convert string to boolean if necessary
  if is_string($manage_firewall) {
    $manage_firewall_bool = str2bool($manage_firewall)
  } else {
    $manage_firewall_bool = $manage_firewall
  }
  validate_bool($manage_firewall_bool)
  validate_bool($service_restart)

  # This is needed only if instances are exclusively defined rather than using the base class
  if ! defined(Class['::memcached::package']) {
    class { '::memcached::package':
      package_ensure => $package_ensure,
      install_dev    => $install_dev,
    }
  }

  $user    = $memcached::params::user
  $pidfile = "/var/run/memcached_${tcp_port}.pid"

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

  case $::osfamily {
    'Debian': {
      $config_file  = "/etc/memcached_${tcp_port}.conf"
      $logfile = "/var/log/memcached_${tcp_port}.log"
      $service_name = 'memcached'
      $init_script = false
      # We don't manage the init script for Debian
    }
    'Windows': {
      $config_file = undef
      $service_name = 'memcached'
      $init_script = false
    }
    default: {
      $config_file  = "/etc/sysconfig/memcached_${tcp_port}"
      $logfile = "/var/log/memcached_${tcp_port}.log"
      $service_name = "memcached_${tcp_port}"
      $init_script  = "/etc/init.d/memcached_${tcp_port}"
    }
  }

  if $service_restart {
    $service_notify_real = Service[$service_name]
  } else {
    $service_notify_real = undef
  }

  if $config_file {
    file { $config_file:
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template($memcached::params::config_tmpl),
      require => Package[$memcached::params::package_name],
      notify  => $service_notify_real,
    }
  }

  if $init_script {
    file { $init_script:
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => template($memcached::params::init_tmpl),
      require => Package[$memcached::params::package_name],
      notify  => $service_notify_real,
    }
  }

  ensure_resource('service', $service_name, {
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasrestart => true,
      hasstatus  => $memcached::params::service_hasstatus,
    }
  )

}
