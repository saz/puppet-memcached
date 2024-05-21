# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [9.0.0]
### Added
- Add support for OpenBSD (#162, #166)
### Changed
- BREAKING CHANGE: Fix Ubuntu pidfile and default user (#160)
- replace systemd::service_limits with systemd::manage_dropin (#169)
- make module firewall < 9.0.0 compatible (#168)
- allow puppet/systemd < 8, add Debian 12 as supported OS (#164)
### Removed
- BREAKING CHANGE: drop EOL Ubuntu 18.04 (#170)
- BREAKING CHANGE: drop puppet6 support (#165)

## [8.3.0]
### Added
- Add max_reqs_per_event option for the memcached config (#136)
- Add support for Puppet < 9, stdlib < 10, firewall < 9, systemd < 7, selinux < 5 (#157)
### Fixed
- Allow disabling PID file (#156)
- README: use new parameter for address binding (#152)
- Bugfix: replace legacy fact in sysconfig-template (#151)
- set file ensure based on $package_ensure (#150)
- fix: wrong camelcase in Stdlib::IP::Address type (#148)

## [8.2.0]
### Added
- Support puppet/systemd < 5.0.0 (#143)
- Support puppetlabs/firewall < 6.0.0
### Changed
- Stop using deprecated Stdlib::Compat::Ip_address (#145)
### Removed
- remove Debian 9 as supported OS

## [8.1.0]
### Added
- Support for RedHat 9 and CentOS 9

## [8.0.0]
### Changed
- BREAKING CHANGE: switch from camptocamp/systemd to puppet/systemd
- Improved tests
- Load modern facts first (#138)
- Make sure memcached logfile exists (#140)
- Allow stdlib < 9.0.0
### Fixed
- Fix duplicate systemd daemon-reload execs (#137)
### Added
- Added support for Debian 11 and Ubuntu 22.04

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
