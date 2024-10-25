#
# @summary Manage multiple memcached instances
#
# @param manage_firewall enable/disable fireall management via puppetlabs/firewall
# @param port the udp and tcp port to listen on. By default, the instance name is used
# @param limits systemd limits for the service
# @param override_content overrides for the unit, as string
# @param override_source overrides for the unit, as file resource
#
# @author pglushchenko <pgl@aroma-zone.com>
# @author Tim Meusel <tim@bastelfreak.de>
#
define memcached::instance (
  Boolean $manage_firewall                      = false,
  Stdlib::Port::Unprivileged $port              = Integer($name),
  Optional[Systemd::ServiceLimits] $limits      = undef,
  Optional[String[1]] $override_content         = undef,
  Optional[Stdlib::Filesource] $override_source = undef,
) {
  unless $facts['kernel'] == 'Linux' {
    fail("memcached::instance currently only works with Linux, you are running ${facts['kernel']}")
  }
  require memcached
  require memcached::instance::servicefile

  $service_name = "memcached@${port}.service"
  if $manage_firewall {
    firewall { "100_tcp_${port}_for_memcached":
      dport => $port,
      proto => 'tcp',
      jump  => 'accept',
    }
  }

  service { $service_name:
    ensure => 'running',
    enable => true,
  }

  if $limits {
    systemd::manage_dropin { "${service_name}-90-limits.conf":
      unit           => $service_name,
      filename       => '90-limits.conf',
      notify_service => true,
      service_entry  => $limits,
    }
  }

  if $override_content or $override_source {
    if $override_content and $override_source {
      fail('memcached::instance: you can only set override_content OR override_source, dont set both')
    }
    systemd::dropin_file { "${service_name}-override.conf":
      unit    => $service_name,
      source  => $override_source,
      content => $override_content,
    }
  }

  if $facts['os']['selinux']['enabled'] {
    selinux::port { "allow-${service_name}":
      ensure   => 'present',
      seltype  => 'memcache_port_t',
      protocol => 'tcp',
      port     => $port,
      before   => Service[$service_name],
    }
  }
}
