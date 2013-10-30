class memcached::params {
  case $::osfamily {
    'Debian': {
      $package_name      = 'memcached'
      $service_name      = 'memcached'
      $service_hasstatus = false
      $dev_package_name  = 'libmemcached-dev'
      $config_file       = '/etc/memcached.conf'
      $config_tmpl       = "${module_name}/memcached.conf.erb"
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
      fail("Unsupported platform: ${::osfamily}")
    }
  }
  case $::operatingsystem {
    'Ubuntu': {
      $user = 'memcache'
    }
    'Debian': {
      $user = 'nobody'
    }
    default: {
      $user = 'memcached'
    }
  }
}
