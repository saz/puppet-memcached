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
      if $::service_provider == 'systemd' {
        $systemd           = true
        $systemd_conf_path = '/etc/systemd/system/memcached.service'
      } else {
        $systemd           = false
        $systemd_conf_path = undef
      }
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
      if $::service_provider == 'systemd' {
        $systemd           = true
        $systemd_conf_path = '/usr/lib/systemd/system/memcached.service'
      } else {
        $systemd           = false
        $systemd_conf_path = undef
      }
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
      $systemd           = false
      $systemd_conf_path = undef
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
      $systemd           = false
      $systemd_conf_path = undef
    }
    'FreeBSD': {
      $package_name      = 'memcached'
      $package_provider  = undef
      $service_name      = 'memcached'
      $service_hasstatus = false
      $dev_package_name  = 'libmemcached'
      $config_file       = '/etc/rc.conf.d/memcached'
      $config_tmpl       = "${module_name}/memcached_freebsd_rcconf.erb"
      $user              = 'nobody'
      $logfile           = '/var/log/memcached.log'
      $use_registry      = false
      $use_svcprop       = false
      $systemd           = false
      $systemd_conf_path = undef
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
          $systemd           = false
          $systemd_conf_path = undef
        }
        default: {
          fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  }
}
