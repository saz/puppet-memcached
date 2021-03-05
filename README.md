# puppet-memcached [![Build Status](https://secure.travis-ci.org/saz/puppet-memcached.png)](http://travis-ci.org/saz/puppet-memcached)

Manage memcached via Puppet

## Show some love
If you find this module useful, send some bitcoins to 1Na3YFUmdxKxJLiuRXQYJU2kiNqA3KY2j9

### Supported Puppet versions
* Puppet >= 5
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

### Install multiple memcached instances

the multiinstance support uses a systemd instance unit file. This will be placed
at `/etc/systemd/system/memcached@.service`. It allows us to manage multiple
instances via the same unit file. To start a simple instance, you only need to
know the desired TCP port:

```puppet
memcached::instance{'11222':}
```

that's it! It will bind to localhost and listen to TCP port 11222. You might
want to tune the systemd limits, for example the number of file descriptors
(LimitNOFILE) or the number of processes (LimitNPROC):

```puppet
memcached::instance{'11222':
  limits => {
    'LimitNOFILE' => 8192,
    'LimitNPROC'  => 16384,
  }
}
```

All systemd limits are documented in the [systemd documentation](https://www.freedesktop.org/software/systemd/man/systemd.exec.html#Process%20Properties).

Another usecase. Let's assume your name is Eric and you want to change the
actual memcached parameters, for example to bind it to every interface:

```puppet
memcached::instance{'11222':
  override_content => "[Service]\nEnvironment='LISTEN=-l 0.0.0.0'",
}
```

Maybe Eric also wants to override the cache size (the unit is MB):

```puppet
memcached::instance{'11222':
  override_content => "[Service]\nEnvironment=CACHESIZE=4096\n",
}
```

last but not least, Eric might also want to override the maximum amount
of connections (the default is 1024):

```puppet
memcached::instance{'11222':
  override_content => "[Service]\nEnvironment=MAXCONN=4096\n",
}
```

Now Eric wants to use all those three settings at the same time:

```puppet
memcached::instance{'11222':
  override_content => "[Service]\nEnvironment=MAXCONN=4096\nEnvironment=CACHESIZE=4096\nEnvironment='LISTEN=-l 0.0.0.0'\n",
}
```

Instead of passing a long string with multiple `\n`, Eric can also put the
content in a file and provide that:

```puppet
memcached::instance{'11222':
  override_source => "${module_name}/memcached_11222_override.conf\n",
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
* $listen = '127.0.0.1' (if TLS/SSL is enabled, 'notls' prefix can be used to disable for specific listeners "notls:<ip>:<port>")
* $listen_ip = '127.0.0.1' (deprecated, listen will take precedence over this)
* $tcp_port = 11211
* $udp_port = 0
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
