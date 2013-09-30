# puppet-memcached

[![Build Status](https://secure.travis-ci.org/saz/puppet-memcached.png)](http://travis-ci.org/saz/puppet-memcached)

Manage memcached via Puppet

## How to use

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
* $max_memory = false
* $item_size = false
* $lock_memory = false (WARNING: good if used intelligently, google for -k key)
* $listen_ip = '0.0.0.0'
* $tcp_port = 11211
* $udp_port = 11211
* $user = '' (OS specific setting, see params.pp)
* $max_connections = 8192
* $verbosity = undef
* $unix_socket = undef
* $install_dev = false (TRUE if 'libmemcached-dev' package should be installed)
* $processorcount = $::processorcount
