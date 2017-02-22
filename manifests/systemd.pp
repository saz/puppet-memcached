class memcached::systemd {
  if (!defined(Exec['systemctl-daemon-reload'])) {
    exec {'systemctl-daemon-reload':
      command     => 'systemctl daemon-reload',
      path        => ['/bin','/sbin','/usr/bin','/usr/sbin'],
      refreshonly => true,
    }
  }
}
