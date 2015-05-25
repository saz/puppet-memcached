# == Class: memcached
#
# Manage memcached
#
class memcached (
  $package_ensure  = 'present',
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
  $use_registry    = $::memcached::params::use_registry,
  $registry_key    = 'HKLM\System\CurrentControlSet\services\memcached\ImagePath',
  $large_mem_pages = false,
  $default_instance = true,
  $instance_configs = hiera_hash('memcached::instance_configs', undef),
) inherits memcached::params {

  if $package_ensure == 'absent' {
    $service_ensure = 'stopped'
    $service_enable = false
  } else {
    $service_ensure = 'running'
    $service_enable = true
  }

  class { '::memcached::package':
    package_ensure => $package_ensure,
    install_dev    => $install_dev,
  }

  $default_configs = {
    'memcached' => {
      manage_firewall => $manage_firewall,
      max_memory      => $max_memory,
      item_size       => $item_size,
      lock_memory     => $lock_memory,
      listen_ip       => $listen_ip,
      tcp_port        => $tcp_port,
      udp_port        => $udp_port,
      max_connections => $max_connections,
      verbosity       => $verbosity,
      unix_socket     => $unix_socket,
      processorcount  => $processorcount,
      use_sasl        => $use_sasl,
      large_mem_pages => $large_mem_pages,
      service_ensure  => $service_ensure,
      service_enable  => $service_enable,
    },
  }

  if $default_instance and is_hash($instance_configs) {
    validate_hash($instance_configs)
    $final_configs = merge($default_configs, $instance_configs)
  }
  elsif $default_instance {
    $final_configs = $default_configs
  }
  elsif is_hash($instance_configs) {
    validate_hash($instance_configs)
    $final_configs = $instance_configs
  }

  if ! is_hash($final_configs) {
    fail('No configuration provided to the Memcached class')
  }

  if $use_registry {
    registry_value{ $registry_key:
      ensure => 'present',
      type   => 'string',
      data   => template($memcached::params::config_tmpl),
      notify => Service[$memcached::params::service_name]
    }
  }

  create_resources(memcached::instance, $final_configs)

}
