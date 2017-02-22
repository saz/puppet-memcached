class memcached::systemd {
  if (!defined(Exec['Reload systemd'])) {
    exec {'Reload systemd':
      command     => 'systemctl daemon-reload',
      path        => ['/bin','/sbin','/usr/bin','/usr/sbin'],
      refreshonly => true,
    }
  }
}
