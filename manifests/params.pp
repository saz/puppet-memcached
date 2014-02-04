class memcached::params {

  # Sets osfamily_
  #   osfamily_ is the same than ::osfamily but also considers
  #   Amazon Linux as member of RedHat family
  if ($::osfamily == 'Linux' and $::operatingsystem == 'Amazon') {
    $osfamily_ = 'RedHat'
  } else {
    $osfamily_ = $::osfamily
  }

  case $osfamily_ {
    'Debian': {
      $package_name      = 'memcached'
      $service_name      = 'memcached'
      $service_hasstatus = false
      $dev_package_name  = 'libmemcached-dev'
      $config_file       = '/etc/memcached.conf'
      $config_tmpl       = "${module_name}/memcached.conf.erb"
      $user              = 'nobody'
    }
    'RedHat': {
      $package_name      = 'memcached'
      $service_name      = 'memcached'
      $service_hasstatus = true
      $dev_package_name  = 'libmemcached-devel'
      $config_file       = '/etc/sysconfig/memcached'
      $config_tmpl       = "${module_name}/memcached_sysconfig.erb"
      $user              = 'memcached'
    }
    default: {
      fail("Unsupported platform: ${osfamily_}")
    }
  }
}
