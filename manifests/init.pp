class memcached {
    include memcached::params, memcached::install, memcached::config, memcached::service
}
