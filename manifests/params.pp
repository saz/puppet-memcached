# == Class: memcached::params
#
class memcached::params {
  case $::osfamily {
    'Debian': {
      $package_name      = 'memcached'
      $package_provider  = undef
      $service_name      = 'memcached'
      $service_path      = '/lib/systemd/system/'
      $service_tmpl      = "${module_name}/memcached_systemd.erb"
      $service_hasstatus = false
      $dev_package_name  = 'libmemcached-dev'
      $config_path       = '/etc/'
      $config_ext        = '.conf'
      $config_file       = "${config_path}${service_name}${config_ext}"
      $config_tmpl       = "${module_name}/memcached.conf.erb"
      $user              = 'nobody'
      $logpath           = '/var/log/'
      $logfile           = "${logpath}${service_name}.log"
      $use_registry      = false
      $use_svcprop       = false
    }
    /RedHat|Suse/: {
      $package_name      = 'memcached'
      $package_provider  = undef
      $user              = 'memcached'
      $service_name      = 'memcached'
      $service_path      = '/usr/lib/systemd/system/'
      $service_tmpl      = "${module_name}/memcached_systemd.service.erb"
      $service_hasstatus = true
      $dev_package_name  = 'libmemcached-devel'
      $config_path       = '/etc/sysconfig/'
      $config_ext        = ''
      $config_file       = "${config_path}${service_name}${config_ext}"
      $config_tmpl       = "${module_name}/memcached_sysconfig.erb"
      $logpath           = '/var/log/'
      $logfile           = "${logpath}${service_name}.log"
      $use_registry      = false
      $use_svcprop       = false
    }
    /windows/: {
      $package_name      = 'memcached'
      $package_provider  = 'chocolatey'
      $service_name      = 'memcached'
      $service_hasstatus = true
      $dev_package_name  = 'libmemcached-devel'
      $config_path       = undef
      $config_ext        = undef
      $config_file       = undef
      $config_tmpl       = "${module_name}/memcached_windows.erb"
      $user              = 'BUILTIN\Administrators'
      $logpath           = undef
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
      $config_path       = undef
      $config_ext        = undef
      $config_file       = undef
      $config_tmpl       = "${module_name}/memcached_svcprop.erb"
      $user              = 'nobody'
      $logpath           = '/var/log/'
      $logfile           = "${logpath}${service_name}.log"
      $use_registry      = false
      $use_svcprop       = true
    }
    'FreeBSD': {
      $package_name      = 'memcached'
      $package_provider  = undef
      $service_name      = 'memcached'
      $service_hasstatus = false
      $dev_package_name  = 'libmemcached'
      $config_path       = '/etc/rc.conf.d/'
      $config_ext        = ''
      $config_file       = "${config_path}${service_name}${config_ext}"
      $config_tmpl       = "${module_name}/memcached_freebsd_rcconf.erb"
      $user              = 'nobody'
      $logpath           = '/var/log/'
      $logfile           = "${logpath}${service_name}.log"
      $use_registry      = false
      $use_svcprop       = false
    }
    default: {
      case $::operatingsystem {
        'Amazon': {
          $package_name      = 'memcached'
          $package_provider  = undef
          $service_name      = 'memcached'
          $service_path      = '/usr/lib/systemd/system/'
          $service_tmpl      = "${module_name}/memcached_systemd.service.erb"
          $service_hasstatus = true
          $dev_package_name  = 'libmemcached-devel'
          $config_path       = '/etc/sysconfig/'
          $config_ext        = ''
          $config_file       = "${config_path}${service_name}${config_ext}"
          $config_tmpl       = "${module_name}/memcached_sysconfig.erb"
          $user              = 'memcached'
          $logpath           = '/var/log/'
          $logfile           = "${logpath}${service_name}.log"
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
