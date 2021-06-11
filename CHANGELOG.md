# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [7.0.0]
### Changed
- BREAKING CHANGE: Testing for Puppet 5 has been dropped
- Switched from Travis to Github Actions
- Dependencies updated to support the newest releases

## [6.0.0]
### Added
- Add listen parameter as successor for listen_ip (#127)
### Deprecated
- listen_ip parameter is deprecated in favor of new listen parameter (#127)
### Changed
- Use camptocamp/systemd v2.12.0 for tests, as newer versions might drop support for puppet 5
### Removed
- Dropped notls_listener_addr and notls_listener_port parameter in favor of listen_ip (#128)

## [5.0.0]
### Added
- Add sasl support on RHEL derivatives (#122)
- Add notls_listener_addr and notls_listener_port parameters (#124)
### Changed
- BREAKING CHANGE: Disable UDP by default (#125)
  If you need UDP enabled, set `memcached::udp_port` to a non-zero value, e.g. 11211

## [4.0.0]
### Added
- Support management of multiple memcached instances (systemd required!) #120
- Add FreeBSD to list of supported operatingsystems
### Removed
- Drop support for Puppet 4 (EOL) #116

## [3.7.0]
### Added
- Add support to set TLS parameters in /etc/sysconfig/memcached (#113)
### Fixed
- Make ssl_ca_cert optional (#112)

## [3.6.0]
### Added
- Add TLS support (#109)

## [3.5.0]
### Fixed
- allow FreeBSD to set max memory (#104)
### Changed
- Dependencies updated (#107)
- Better FreeBSD tests

## [3.4.0]
### Fixed
- factor should be a string or number, not boolean
### Added
- Add Puppet 6 to travis checks
### Changed
- Update Puppet version requirement to include version 6 (< 7.0.0)
- Unpin firewall module in fixtures
- Require puppetlabs_spec_helper >= 2.11.0
### Removed
- Drop Ruby 2.1 from travis checks
