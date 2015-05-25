# == Class: memcached::package
#
# Manage memcached installation
#
class memcached::package (
  $package_ensure   = 'present',
  $install_dev      = false,
) inherits memcached::params {

  package { $memcached::params::package_name:
    ensure => $package_ensure,
  }

  if $install_dev {
    package { $memcached::params::dev_package_name:
      ensure  => $package_ensure,
      require => Package[$memcached::params::package_name]
    }
  }

}
