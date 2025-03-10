# @summary
#   This class manages memcached
#
# @example Use default settings
#   include memcached
#
# @param package_ensure
#   Set ensure of the memcached package
#
# @param service_manage
#   Manage the memcached service
#
# @param service_flags
#   Pass flags to the service managed by Puppet
#
# @param logfile
#   Specify file to log to. Not supported on OS using systemd
#
# @param logstdout
#   Disable logging to a file or syslog entirely. Only supported on RedHat-based OS and Suse
#
# @param syslog
#   Log to syslog. Only supported on RedHat-based OS and Suse
#
# @param pidfile
#   Save pid in file
#
# @param manage_firewall
#   Create simple firewall rules. Only supported on Linux
#
# @param max_memory
#   Max memory memcached should use to store items. Either in percent or mb
#
# @param max_item_size
#   Adjusts max item size
#
# @param min_item_size
#   Min space used for key+value+flags
#
# @param factor
#   Chunk size growth factor
#
# @param lock_memory
#   Lock down all paged memory
#
# @param listen
#   Interface to listen on
#
# @param listen_ip
#   Deprecated. Use `listen` instead
#
# @param tcp_port
#   TCP port to listen on
#
# @param udp_port
#   UDP port to listen on
#
# @param user
#   User to run memcached service as
#
# @param max_connections
#   Max simultaneous connections
#
# @param verbosity
#   v: verbose (print errors/warnings while in event loop)
#   vv: very verbose (also print client commands/responses)
#   vvv: extremely verbose (internal state transitions)
#
# @param unix_socket
#   UNIX socket to listen on (disables network support)
#
# @param unix_socket_mask
#   access mask for UNIX socket, in octal
#
# @param install_dev
#   Manage installation of the memcached dev package
#
# @param processorcount
#   Number of threads to use
#
# @param service_restart
#   Whether or not to restart the memcached service on changes
#
# @param auto_removal
#   Return error on memory exhausted instead of evicting
#
# @param use_sasl
#   Turn on SASL authentication
#
# @param use_tls
#   Enable TLS/SSL
#
# @param tls_cert_chain
#   Path to certificate chain file
#
# @param tls_key
#   Path to certificate key file
#
# @param tls_ca_cert
#   Path to CA certificate file
#
# @param tls_verify_mode
#   Peer certificate verify mode
#
# @param use_registry
#
# @param registry_key
#
# @param large_mem_pages
#   Try to use large memory pages (if available)
#
# @param use_svcprop
#
# @param svcprop_fmri
#
# @param svcprop_key
#
# @param extended_opts
#   Array of extended options
#
# @param config_tmpl
#   Use a different config template
#
# @param disable_cachedump
#   Disable stats cachedump and lru_crawler metadump
#
# @param max_reqs_per_event
#   Maximum number of requests per event, limits the
#   requests processed per connection to prevent starvation
#
# @param disable_flush_all
#   Disable flush_all command
#
# @param disable_watch
#   Disable watch commands (live logging)
#
# @param memory_file
#   mmap a file for item memory.
#
class memcached (
  Enum['present', 'latest', 'absent'] $package_ensure                                        = 'present',
  Boolean $service_manage                                                                    = true,
  Optional[String] $service_flags                                                            = $memcached::params::service_flags,
  Optional[Stdlib::Absolutepath] $logfile                                                    = $memcached::params::logfile,
  Boolean $logstdout                                                                         = false,
  Boolean $syslog                                                                            = false,
  Variant[Stdlib::Absolutepath, Boolean[false], Undef] $pidfile                              = $memcached::params::pidfile,
  Boolean $manage_firewall                                                                   = false,
  Variant[Integer[0], Pattern[/^1?\d?\d%$/]] $max_memory                                     = '95%',
  Optional[Variant[Integer, String]] $max_item_size                                          = undef,
  Optional[Variant[Integer, String]] $min_item_size                                          = undef,
  Optional[Variant[Integer, String]] $factor                                                 = undef,
  Boolean $lock_memory                                                                       = false,
  Optional[Variant[String,Array[String]]] $listen                                            = undef,
  Optional[Variant[Stdlib::IP::Address,Array[Stdlib::IP::Address]]] $listen_ip               = undef,
  Integer $tcp_port                                                                          = 11211,
  Integer $udp_port                                                                          = 0,
  String $user                                                                               = $memcached::params::user,
  Integer $max_connections                                                                   = 8192,
  Optional[Enum['v', 'vv', 'vvv']] $verbosity                                                = undef,
  Optional[String] $unix_socket                                                              = undef,
  String $unix_socket_mask                                                                   = '0755',
  Boolean $install_dev                                                                       = false,
  Variant[String,Integer] $processorcount                                                    = $facts['processors']['count'],
  Boolean $service_restart                                                                   = true,
  Boolean $auto_removal                                                                      = false,
  Boolean $use_sasl                                                                          = false,
  Boolean $use_tls                                                                           = false,
  Optional[Stdlib::Absolutepath] $tls_cert_chain                                             = undef,
  Optional[Stdlib::Absolutepath] $tls_key                                                    = undef,
  Optional[Stdlib::Absolutepath] $tls_ca_cert                                                = undef,
  Integer[0,3] $tls_verify_mode                                                              = 1,
  Boolean $use_registry                                                                      = $memcached::params::use_registry,
  String $registry_key                                                                       = 'HKLM\System\CurrentControlSet\services\memcached\ImagePath',
  Boolean $large_mem_pages                                                                   = false,
  Boolean $use_svcprop                                                                       = $memcached::params::use_svcprop,
  String $svcprop_fmri                                                                       = 'memcached:default',
  String $svcprop_key                                                                        = 'memcached/options',
  Optional[Array[String]] $extended_opts                                                     = undef,
  String $config_tmpl                                                                        = $memcached::params::config_tmpl,
  Boolean $disable_cachedump                                                                 = false,
  Optional[Integer] $max_reqs_per_event                                                      = undef,
  Boolean $disable_flush_all                                                                 = false,
  Boolean $disable_watch                                                                     = false,
  Optional[Stdlib::Absolutepath] $memory_file                                                = undef,
) inherits memcached::params {
  # Logging to syslog and file are mutually exclusive
  # Fail if both options are defined
  if $syslog and str2bool($logfile) {
    fail 'Define either syslog or logfile as logging destinations but not both.'
  }

  if $use_tls {
    if $tls_cert_chain == undef or $tls_key == undef {
      fail 'tls_cert_chain and tls_key should be set when use_tls is true.'
    }
  }

  if $package_ensure == 'absent' {
    $service_ensure = 'stopped'
    $service_enable = false
    $file_ensure = 'absent'
  } else {
    $service_ensure = 'running'
    $service_enable = true
    $file_ensure = 'file'
  }

  if ! $listen and ! $listen_ip {
    # if both are not set, we're setting $real_listen to 127.0.0.1
    $real_listen = ['127.0.0.1']
  } else {
    if $listen {
      # Handle if $listen is not an array
      $real_listen = [$listen]
    } else {
      warning('memcached::listen_ip is deprecated in favor of memcached::listen')
      # Handle if $listen_ip is not an array
      $real_listen = [$listen_ip]
    }
  }

  package { $memcached::params::package_name:
    ensure   => $package_ensure,
    provider => $memcached::params::package_provider,
  }

  if $install_dev {
    package { $memcached::params::dev_package_name:
      ensure  => $package_ensure,
      require => Package[$memcached::params::package_name],
    }
  }

  if $facts['kernel'] == 'Linux' and $manage_firewall {
    firewall { "100_tcp_${tcp_port}_for_memcached":
      dport => $tcp_port,
      proto => 'tcp',
      jump  => 'accept',
    }

    if $udp_port != 0 {
      firewall { "100_udp_${udp_port}_for_memcached":
        dport => $udp_port,
        proto => 'udp',
        jump  => 'accept',
      }
    }
  }

  if $service_restart and $service_manage {
    $service_notify_real = Service[$memcached::params::service_name]
  } else {
    $service_notify_real = undef
  }

  if ( $memcached::params::config_file ) {
    file { $memcached::params::config_file:
      ensure  => $file_ensure,
      owner   => 'root',
      group   => 0,
      mode    => '0644',
      content => template($config_tmpl),
      require => Package[$memcached::params::package_name],
      notify  => $service_notify_real,
    }
  }

  if $logfile and !$syslog {
    file { $logfile:
      ensure  => $file_ensure,
      owner   => $user,
      group   => 0,
      mode    => '0640',
      require => Package[$memcached::params::package_name],
      notify  => $service_notify_real,
    }
  }

  if $service_manage {
    service { $memcached::params::service_name:
      ensure     => $service_ensure,
      enable     => $service_enable,
      flags      => $service_flags,
      hasrestart => true,
      hasstatus  => $memcached::params::service_hasstatus,
    }
  }

  if $use_registry {
    registry_value { $registry_key:
      ensure => 'present',
      type   => 'string',
      data   => template($config_tmpl),
      notify => $service_notify_real,
    }
  }

  if $use_svcprop {
    svcprop { $svcprop_key:
      fmri     => $svcprop_fmri,
      property => $svcprop_key,
      value    => template($memcached::params::config_tmpl),
      notify   => $service_notify_real,
    }
  }
}
