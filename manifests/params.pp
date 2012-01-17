class memcached::params {
  case $::operatingsystem {
    ubuntu, debian: {
      $package_name = 'memcached'
      $service_name = 'memcached'
      $config_file  = '/etc/memcached.conf'
      $config_tmpl  = "${module_name}/memcached.conf.erb"
      $default_user = 'nobody'
    }
    centos, redhat: {
      $package_name = 'memcached'
      $service_name = 'memcached'
      $config_file = '/etc/sysconfig/memcached'
      $config_tmpl  = "${module_name}/memcached_sysconfig.erb"
      $default_user = 'memcached'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}
