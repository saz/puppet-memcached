#
# @summary helper class to configure the memcache multiinstance unit file *once*
#
# @api private
#
# @author Tim Meusel <tim@bastelfreak.de>
#
class memcached::instance::servicefile {
  assert_private()
  systemd::unit_file { 'memcached@.service':
    content => epp("${module_name}/memcached@.service.epp"),
  }
}
