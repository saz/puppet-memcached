# puppet-memcached [![Build Status](https://secure.travis-ci.org/saz/puppet-memcached.png)](http://travis-ci.org/saz/puppet-memcached)

Manage memcached via Puppet

## Show some love
If you find this module useful, send some bitcoins to 1Na3YFUmdxKxJLiuRXQYJU2kiNqA3KY2j9

## How to use

```
Starting with version 3.0.0, memcached will be listening on 127.0.0.1 only.
This should make setups more secure (e.g. if there are no firewall rules in place).

To change this behavior, you need to set listen_ip to '0.0.0.0'.
```

### Use roughly 90% of memory

```ruby
    class { 'memcached': }
```

### Set a fixed memory limit in MB

```ruby
    class { 'memcached':
      max_memory => 2048
    }
```

### Use 12% of available memory

```ruby
    class { 'memcached':
      max_memory => '12%'
    }
```

### Other class parameters

* $package_ensure = 'present'
* $logfile = '/var/log/memcached.log'
* $pidfile = '/var/run/memcached.pid' (Debian family only, set to false to disable pidfile)
* $max_memory = false
* $max_item_size = false
* $min_item_size = false
* $factor = false
* $lock_memory = false (WARNING: good if used intelligently, google for -k key)
* $listen_ip = '127.0.0.1'
* $tcp_port = 11211
* $udp_port = 11211
* $manage_firewall = false
* $user = '' (OS specific setting, see params.pp)
* $max_connections = 8192
* $verbosity = undef
* $unix_socket = undef
* $install_dev = false (TRUE if 'libmemcached-dev' package should be installed)
* $processorcount = $::processorcount
* $service_restart = true (restart service after configuration changes, false to prevent restarts)
* $use_sasl = false (start memcached with SASL support)
* $large_mem_pages = false (try to use large memory pages)
* $auto_restart = false (when `systemd` is available, use it to restart the daemon on abnormal exits)
* $systemd_conf_path = _see params.pp_ (where to dump the systemd service file for `$auto_restart`)
