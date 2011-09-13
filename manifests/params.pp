class memcached::params {
    case $operatingsystem {
        /(Ubuntu|Debian)/: {
            $package_name = 'memcached'
            $service_name = 'memcached'
            $config_file = '/etc/memcached.conf'
        }
    }

    case $memcached_logfile {
        '': { $logfile = '/var/log/memcached.log' }
        default: { $logfile = $memcached_logfile }
    }

    case $memcached_max_memory {
        '': { $max_memory = false }
        default: { $max_memory = $memcached_max_memory }
    }

    case $memcached_listen_ip {
        '': { $listen_ip = '0.0.0.0' }
        default: { $listen_ip = $memcached_listen_ip }
    }

    case $memcached_tcp_port {
        '': { $tcp_port = 11211 }
        default: { $tcp_port = $memcached_tcp_port }
    }

    case $memcached_udp_port {
        '': { $udp_port = 11211 }
        default: { $udp_port = $memcached_udp_port }
    }

    case $memcached_user {
        '': { $user = 'nobody' }
        default: { $user = $memcached_user }
    }

    case $memcached_max_connections {
        '': { $max_connections = 8192 }
        default: { $max_connections = $memcached_max_connections }
    }
}
