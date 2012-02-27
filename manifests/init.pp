class memcached(
  $package_ensure  = $::memcached::params::package_ensure,
  $logfile         = $::memcached::params::logfile,
  $max_memory      = $::memcached::params::max_memory,
  $listen_ip       = $::memcached::params::listen_ip,
  $tcp_port        = $::memcached::params::tcp_port,
  $udp_port        = $::memcached::params::udp_port,
  $user            = $::memcached::params::user,
  $max_connections = $::memcached::params::max_connections
) inherits memcached::params {

  if !($::operatingsystem in ['ubuntu','debian','centos','redhat']) {
    fail("Unsupported platform for memcached module: ${::operatingsystem}")
  }

  package { $memcached::params::package_name:
    ensure => $memcached::params::package_ensure,
  }

  file { $memcached::params::config_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($memcached::params::config_tmpl),
    require => Package[$memcached::params::package_name],
  }

  service { $memcached::params::service_name:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => false,
    subscribe  => File[$memcached::params::config_file],
  }
}
