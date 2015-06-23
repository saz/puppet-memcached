# == Class: memcached::params
#
class memcached::params {
  case $::osfamily {
    'Debian': {
      $package_name      = 'memcached'
      $package_provider  = undef
      $service_name      = 'memcached'
      $service_hasstatus = false
      $dev_package_name  = 'libmemcached-dev'
      $config_file       = '/etc/memcached.conf'
      $config_tmpl       = "${module_name}/memcached.conf.erb"
      $user              = 'nobody'
      $logfile           = '/var/log/memcached.log'
      $use_registry      = false
      $use_svcprop       = false
    }
    /RedHat|Suse/: {
      $package_name      = 'memcached'
      $package_provider  = undef
      $service_name      = 'memcached'
      $service_hasstatus = true
      $dev_package_name  = 'libmemcached-devel'
      $config_file       = '/etc/sysconfig/memcached'
      $config_tmpl       = "${module_name}/memcached_sysconfig.erb"
      $user              = 'memcached'
      $logfile           = '/var/log/memcached.log'
      $use_registry      = false
      $use_svcprop       = false
    }
    /windows/: {
      $package_name      = 'memcached'
      $package_provider  = 'chocolatey'
      $service_name      = 'memcached'
      $service_hasstatus = true
      $dev_package_name  = 'libmemcached-devel'
      $config_file       = undef
      $config_tmpl       = "${module_name}/memcached_windows.erb"
      $user              = 'BUILTIN\Administrators'
      $logfile           = undef
      $use_registry      = true
      $use_svcprop       = false
    }
    'Solaris': {
      $package_name      = 'memcached'
      $package_provider  = undef
      $service_name      = 'memcached'
      $service_hasstatus = false
      $dev_package_name  = 'libmemcached'
      $config_file       = undef
      $config_tmpl       = "${module_name}/memcached_svcprop.erb"
      $user              = 'nobody'
      $logfile           = '/var/log/memcached.log'
      $use_registry      = false
      $use_svcprop       = true
    }
    default: {
      case $::operatingsystem {
        'Amazon': {
          $package_name      = 'memcached'
          $package_provider  = undef
          $service_name      = 'memcached'
          $service_hasstatus = true
          $dev_package_name  = 'libmemcached-devel'
          $config_file       = '/etc/sysconfig/memcached'
          $config_tmpl       = "${module_name}/memcached_sysconfig.erb"
          $user              = 'memcached'
          $logfile           = '/var/log/memcached.log'
          $use_registry      = false
          $use_svcprop       = false
        }
        default: {
          fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  }
}
