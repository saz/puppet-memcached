# puppet-memcached

Manage memcached via Puppet

## How to use

### Use roughly 90% of memory

```
    include memcached
```

### Set a fixed memory limit in MB

```
    $memcached_max_memory = 2048
    include memcached
```

### Other variables

* $memcached_logfile = '/var/log/memcached.log'
* $memcached_listen_ip = '0.0.0.0'
* $memcached_tcp_port = 11211
* $memcached_udp_port = 11211
* $memcached_user = 'nobody'
* $memcached_max_connections = 8192
