# puppet-memcached [![Build Status](https://secure.travis-ci.org/saz/puppet-memcached.png)](http://travis-ci.org/saz/puppet-memcached)

Manage memcached via Puppet

## Show some love
If you find this module useful, send some bitcoins to 1Na3YFUmdxKxJLiuRXQYJU2kiNqA3KY2j9

### Supported Puppet versions
* Puppet >= 4
* Last version supporting Puppet 3: v3.0.2

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
* $logstdout = false (Set this to true to disable logging to a file/syslog entirely, useful when memcached runs in containers)
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
* $use_tls = false (start memcached with TLS support)
* $tls_cert_chain = undef
* $tls_key = undef
* $tls_ca_cert = undef
* $tls_verify_mode = 1 (0: None, 1: Request, 2: Require, 3: Once)
* $large_mem_pages = false (try to use large memory pages)
