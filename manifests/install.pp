class memcached::install {
    package { $memcached::params::package_name:
        ensure => present,
    }
}
