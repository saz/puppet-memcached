class memcached::params {
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
        $package_name = 'memcached'
        $service_name = 'memcached'
        $config_file = '/etc/memcached.conf'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}
