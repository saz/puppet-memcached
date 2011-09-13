class memcached::config {
    file { $memcached::params::config_file:
        ensure  => present,
        owner   => root,
        group   => root,
        content => template("${module_name}/memcached.conf.erb"),
        require => Class['memcached::install'],
        notify  => Class['memcached::service'],
    }
}
