class memcached::service {
    service { $memcached::params::service_name:
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => false,
        require    => Class['memcached::config'],
    }
}
