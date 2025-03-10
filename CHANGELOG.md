# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v10.0.1](https://github.com/saz/puppet-memcached/tree/v10.0.1) (2025-03-10)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v10.0.0...v10.0.1)

**Fixed bugs:**

- Accept integer value for max\_memory [\#187](https://github.com/saz/puppet-memcached/pull/187) ([kajinamit](https://github.com/kajinamit))

**Closed issues:**

- memcached::max\_memory no longer accepts an integer [\#186](https://github.com/saz/puppet-memcached/issues/186)

## [v10.0.0](https://github.com/saz/puppet-memcached/tree/v10.0.0) (2025-03-07)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v9.0.0...v10.0.0)

**Breaking changes:**

- Remove Scientific LINUX [\#180](https://github.com/saz/puppet-memcached/pull/180) ([kajinamit](https://github.com/kajinamit))
- drop OracleLinux 7, add 8 and 9 as supported OS [\#176](https://github.com/saz/puppet-memcached/pull/176) ([saz](https://github.com/saz))
- remove some eol OS [\#174](https://github.com/saz/puppet-memcached/pull/174) ([saz](https://github.com/saz))
- Drop workaround for Puppet 5 [\#172](https://github.com/saz/puppet-memcached/pull/172) ([kajinamit](https://github.com/kajinamit))

**Implemented enhancements:**

- Bump upper limit of puppet-systemd [\#179](https://github.com/saz/puppet-memcached/pull/179) ([kajinamit](https://github.com/kajinamit))
- add disable-flush-all, disable-watch and memory-file parameter [\#177](https://github.com/saz/puppet-memcached/pull/177) ([saz](https://github.com/saz))
- add Ubuntu 24.04 as supported OS [\#175](https://github.com/saz/puppet-memcached/pull/175) ([saz](https://github.com/saz))

**Merged pull requests:**

- improve documentation, add REFERENCE.md [\#178](https://github.com/saz/puppet-memcached/pull/178) ([saz](https://github.com/saz))

## [v9.0.0](https://github.com/saz/puppet-memcached/tree/v9.0.0) (2024-05-21)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v8.3.0...v9.0.0)

**Closed issues:**

- Default pidfile on Ubuntu misplaced [\#159](https://github.com/saz/puppet-memcached/issues/159)
- Make release at puppet forge compatible with Puppet 8 [\#154](https://github.com/saz/puppet-memcached/issues/154)
- Default user on debian to "memcache" [\#105](https://github.com/saz/puppet-memcached/issues/105)

**Merged pull requests:**

- release: v9.0.0 [\#171](https://github.com/saz/puppet-memcached/pull/171) ([saz](https://github.com/saz))
- drop EOL Ubuntu 18.04 [\#170](https://github.com/saz/puppet-memcached/pull/170) ([saz](https://github.com/saz))
- replace systemd::service\_limits with systemd::manage\_dropin [\#169](https://github.com/saz/puppet-memcached/pull/169) ([saz](https://github.com/saz))
- support newer firewall module [\#168](https://github.com/saz/puppet-memcached/pull/168) ([saz](https://github.com/saz))
- add pidfile value to OpenBSD params [\#166](https://github.com/saz/puppet-memcached/pull/166) ([saz](https://github.com/saz))
- drop puppet6 support [\#165](https://github.com/saz/puppet-memcached/pull/165) ([saz](https://github.com/saz))
- allow puppet/systemd \< 8, add Debian 12 as supported OS [\#164](https://github.com/saz/puppet-memcached/pull/164) ([saz](https://github.com/saz))
- Update from modulesync\_config [\#163](https://github.com/saz/puppet-memcached/pull/163) ([saz](https://github.com/saz))
- Add support for OpenBSD [\#162](https://github.com/saz/puppet-memcached/pull/162) ([buzzdeee](https://github.com/buzzdeee))
- Fix Ubuntu pidfile and default user [\#160](https://github.com/saz/puppet-memcached/pull/160) ([toggetit](https://github.com/toggetit))

## [v8.3.0](https://github.com/saz/puppet-memcached/tree/v8.3.0) (2024-02-26)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v8.2.0...v8.3.0)

**Closed issues:**

- Upstream release with Puppet 8 support? [\#153](https://github.com/saz/puppet-memcached/issues/153)
- package\_ensure: absent will assume the memcached user exists [\#149](https://github.com/saz/puppet-memcached/issues/149)
- Disabling pidfile not possible [\#142](https://github.com/saz/puppet-memcached/issues/142)

**Merged pull requests:**

- prepare release: 8.3.0 [\#158](https://github.com/saz/puppet-memcached/pull/158) ([saz](https://github.com/saz))
- update all dependencies [\#157](https://github.com/saz/puppet-memcached/pull/157) ([saz](https://github.com/saz))
- Allow disabling PID file [\#156](https://github.com/saz/puppet-memcached/pull/156) ([siebrand](https://github.com/siebrand))
- README: use new parameter for address binding  [\#152](https://github.com/saz/puppet-memcached/pull/152) ([thtomate](https://github.com/thtomate))
- Bugfix: replace legacy fact in sysconfig-template [\#151](https://github.com/saz/puppet-memcached/pull/151) ([sircubbi](https://github.com/sircubbi))
- set file ensure based on $package\_ensure, fixes \#149 [\#150](https://github.com/saz/puppet-memcached/pull/150) ([saz](https://github.com/saz))
- fix: wrong camelcase in Stdlib::IP::Address type [\#148](https://github.com/saz/puppet-memcached/pull/148) ([saz](https://github.com/saz))
- Add max\_reqs\_per\_event option for the memcached config [\#136](https://github.com/saz/puppet-memcached/pull/136) ([s10](https://github.com/s10))

## [v8.2.0](https://github.com/saz/puppet-memcached/tree/v8.2.0) (2023-05-26)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v8.1.0...v8.2.0)

**Merged pull requests:**

- prepare release v8.2.0 [\#147](https://github.com/saz/puppet-memcached/pull/147) ([saz](https://github.com/saz))
- Stop using deprecated Stdlib::Compat::Ip\_address [\#145](https://github.com/saz/puppet-memcached/pull/145) ([traylenator](https://github.com/traylenator))
- Update from modulesync\_config [\#144](https://github.com/saz/puppet-memcached/pull/144) ([saz](https://github.com/saz))
- Bump upper version of puppet-systemd [\#143](https://github.com/saz/puppet-memcached/pull/143) ([kajinamit](https://github.com/kajinamit))

## [v8.1.0](https://github.com/saz/puppet-memcached/tree/v8.1.0) (2022-07-11)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v8.0.0...v8.1.0)

**Merged pull requests:**

- Support CentOS 9/RHEL 9 [\#141](https://github.com/saz/puppet-memcached/pull/141) ([kajinamit](https://github.com/kajinamit))

## [v8.0.0](https://github.com/saz/puppet-memcached/tree/v8.0.0) (2022-07-10)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v7.0.0...v8.0.0)

**Closed issues:**

- Passing an array to memcached::listen doesn't work [\#133](https://github.com/saz/puppet-memcached/issues/133)
- Deprecation warning is shown by default [\#131](https://github.com/saz/puppet-memcached/issues/131)
- Error while evaluating a Function Call, Failed to parse template memcached/memcached\_sysconfig.erb \(Version 3.7.0\) [\#115](https://github.com/saz/puppet-memcached/issues/115)

**Merged pull requests:**

- Make sure memcached logfile exists [\#140](https://github.com/saz/puppet-memcached/pull/140) ([danifr](https://github.com/danifr))
- Support CentOS 8/RHEL 8 [\#139](https://github.com/saz/puppet-memcached/pull/139) ([kajinamit](https://github.com/kajinamit))
- Load modern facts first [\#138](https://github.com/saz/puppet-memcached/pull/138) ([kajinamit](https://github.com/kajinamit))
- manifests/instance: Fix duplicate systemd daemon-reload execs [\#137](https://github.com/saz/puppet-memcached/pull/137) ([jonasdemoor](https://github.com/jonasdemoor))
- Update from saz modulesync\_config [\#135](https://github.com/saz/puppet-memcached/pull/135) ([saz](https://github.com/saz))

## [v7.0.0](https://github.com/saz/puppet-memcached/tree/v7.0.0) (2021-06-11)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v6.0.0...v7.0.0)

**Closed issues:**

- support puppetlabs-firewall 3.0.0 [\#129](https://github.com/saz/puppet-memcached/issues/129)

**Merged pull requests:**

- sync module config [\#130](https://github.com/saz/puppet-memcached/pull/130) ([saz](https://github.com/saz))

## [v6.0.0](https://github.com/saz/puppet-memcached/tree/v6.0.0) (2021-03-09)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v5.0.0...v6.0.0)

**Merged pull requests:**

- Revert "Add notls\_listener\_addr and notls\_listener\_port paramenters" [\#128](https://github.com/saz/puppet-memcached/pull/128) ([moisesguimaraes](https://github.com/moisesguimaraes))
- Add listen\_addr option [\#127](https://github.com/saz/puppet-memcached/pull/127) ([moisesguimaraes](https://github.com/moisesguimaraes))

## [v5.0.0](https://github.com/saz/puppet-memcached/tree/v5.0.0) (2021-01-07)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v4.0.0...v5.0.0)

**Closed issues:**

- use\_sasl not working on rhel systems/sysconfig [\#123](https://github.com/saz/puppet-memcached/issues/123)

**Merged pull requests:**

- Disable UDP by default [\#125](https://github.com/saz/puppet-memcached/pull/125) ([moisesguimaraes](https://github.com/moisesguimaraes))
- Add notls\_listener\_addr and notls\_listener\_port paramenters [\#124](https://github.com/saz/puppet-memcached/pull/124) ([moisesguimaraes](https://github.com/moisesguimaraes))
- Adds sasl support to RHEL derivatives [\#122](https://github.com/saz/puppet-memcached/pull/122) ([khudson](https://github.com/khudson))

## [v4.0.0](https://github.com/saz/puppet-memcached/tree/v4.0.0) (2020-12-04)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v3.7.0...v4.0.0)

**Closed issues:**

- Add FreeBSD to list of supported operating systems [\#121](https://github.com/saz/puppet-memcached/issues/121)
- allow create multiple instance [\#106](https://github.com/saz/puppet-memcached/issues/106)

**Merged pull requests:**

- Manage multiple memcached instances [\#120](https://github.com/saz/puppet-memcached/pull/120) ([bastelfreak](https://github.com/bastelfreak))
- migrate to rspec-puppet-facts [\#119](https://github.com/saz/puppet-memcached/pull/119) ([bastelfreak](https://github.com/bastelfreak))
- Implement basic acceptance tests [\#118](https://github.com/saz/puppet-memcached/pull/118) ([bastelfreak](https://github.com/bastelfreak))
- apply Vox Pupuli Gemfile/Rakefile & apply up2date puppet-lint recommendations [\#117](https://github.com/saz/puppet-memcached/pull/117) ([bastelfreak](https://github.com/bastelfreak))
- Drop EOL Puppet 4 support [\#116](https://github.com/saz/puppet-memcached/pull/116) ([bastelfreak](https://github.com/bastelfreak))

## [v3.7.0](https://github.com/saz/puppet-memcached/tree/v3.7.0) (2020-09-05)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v3.6.0...v3.7.0)

**Merged pull requests:**

- Add support to set TLS parameters in /etc/sysconfig/memcached [\#113](https://github.com/saz/puppet-memcached/pull/113) ([kajinamit](https://github.com/kajinamit))
- Make ssl\_ca\_cert optional [\#112](https://github.com/saz/puppet-memcached/pull/112) ([kajinamit](https://github.com/kajinamit))

## [v3.6.0](https://github.com/saz/puppet-memcached/tree/v3.6.0) (2020-09-03)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v3.5.0...v3.6.0)

**Merged pull requests:**

- Add TLS parameters [\#109](https://github.com/saz/puppet-memcached/pull/109) ([moisesguimaraes](https://github.com/moisesguimaraes))

## [v3.5.0](https://github.com/saz/puppet-memcached/tree/v3.5.0) (2020-05-12)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v3.4.0...v3.5.0)

**Closed issues:**

- Please bump puppetlabs-firewall dependency [\#108](https://github.com/saz/puppet-memcached/issues/108)
- No changelog available [\#102](https://github.com/saz/puppet-memcached/issues/102)

**Merged pull requests:**

- Updating version dependencies [\#107](https://github.com/saz/puppet-memcached/pull/107) ([cubiclelord](https://github.com/cubiclelord))

## [v3.4.0](https://github.com/saz/puppet-memcached/tree/v3.4.0) (2019-01-22)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v3.3.0...v3.4.0)

**Closed issues:**

- max memory size is never calculated unless percentage is used [\#100](https://github.com/saz/puppet-memcached/issues/100)

**Merged pull requests:**

- growth factor should be integer/string [\#103](https://github.com/saz/puppet-memcached/pull/103) ([anesterova](https://github.com/anesterova))
- allow puppet 6.x [\#101](https://github.com/saz/puppet-memcached/pull/101) ([bastelfreak](https://github.com/bastelfreak))

## [v3.3.0](https://github.com/saz/puppet-memcached/tree/v3.3.0) (2018-07-19)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v3.2.0...v3.3.0)

**Merged pull requests:**

- Add the logstdout bool parameter ti disable syslog/file logging completely [\#99](https://github.com/saz/puppet-memcached/pull/99) ([mbaldessari](https://github.com/mbaldessari))
- Allow an array of IP addresses in addition to a single IP address [\#98](https://github.com/saz/puppet-memcached/pull/98) ([cubiclelord](https://github.com/cubiclelord))

## [v3.2.0](https://github.com/saz/puppet-memcached/tree/v3.2.0) (2018-07-07)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v3.1.0...v3.2.0)

**Closed issues:**

- svcprop template has trailing newline [\#96](https://github.com/saz/puppet-memcached/issues/96)
- retun\_types only work Puppet 4.8 later  [\#94](https://github.com/saz/puppet-memcached/issues/94)

**Merged pull requests:**

- Remove trailing whitespace from svcprop value. [\#97](https://github.com/saz/puppet-memcached/pull/97) ([matmannion](https://github.com/matmannion))
- .rubocop.yml : update TrailingCommainLiteral [\#95](https://github.com/saz/puppet-memcached/pull/95) ([andrewspiers](https://github.com/andrewspiers))

## [v3.1.0](https://github.com/saz/puppet-memcached/tree/v3.1.0) (2018-01-09)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v3.0.2...v3.1.0)

**Closed issues:**

- Changelog? [\#87](https://github.com/saz/puppet-memcached/issues/87)

**Merged pull requests:**

- use puppet4 functions-api [\#92](https://github.com/saz/puppet-memcached/pull/92) ([juliantodt](https://github.com/juliantodt))
- Add option to disable memcached's cachedump [\#90](https://github.com/saz/puppet-memcached/pull/90) ([derekhiggins](https://github.com/derekhiggins))
- Fix .rubocop.yml issues [\#89](https://github.com/saz/puppet-memcached/pull/89) ([JAORMX](https://github.com/JAORMX))
- Make sysconfig configuration work with undef values for logfile [\#88](https://github.com/saz/puppet-memcached/pull/88) ([JAORMX](https://github.com/JAORMX))
- Unix socket mask [\#86](https://github.com/saz/puppet-memcached/pull/86) ([obi11235](https://github.com/obi11235))
- Implement puppet4 datatypes [\#84](https://github.com/saz/puppet-memcached/pull/84) ([bastelfreak](https://github.com/bastelfreak))

## [v3.0.2](https://github.com/saz/puppet-memcached/tree/v3.0.2) (2017-05-10)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v3.0.1...v3.0.2)

**Closed issues:**

- $max\_memory parameter is not a boolean [\#85](https://github.com/saz/puppet-memcached/issues/85)

## [v3.0.1](https://github.com/saz/puppet-memcached/tree/v3.0.1) (2017-01-06)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v3.0.0...v3.0.1)

**Closed issues:**

- 3.0.0 contains an additional colon typo in memcached\_max\_memory.rb [\#82](https://github.com/saz/puppet-memcached/issues/82)

## [v3.0.0](https://github.com/saz/puppet-memcached/tree/v3.0.0) (2017-01-06)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v2.8.1...v3.0.0)

**Closed issues:**

- CentOS 7 unix\_socket does nothing [\#78](https://github.com/saz/puppet-memcached/issues/78)
- Any chance of a release soon? [\#75](https://github.com/saz/puppet-memcached/issues/75)
- Set additional memcached options [\#71](https://github.com/saz/puppet-memcached/issues/71)
- Default `listen_ip` [\#66](https://github.com/saz/puppet-memcached/issues/66)
- "Permission denied" error when trying to write PID file as non-root user [\#64](https://github.com/saz/puppet-memcached/issues/64)
- Upstart service installation error [\#62](https://github.com/saz/puppet-memcached/issues/62)
- Single-instance config not working [\#61](https://github.com/saz/puppet-memcached/issues/61)
- Support multiple memcache instances [\#18](https://github.com/saz/puppet-memcached/issues/18)

**Merged pull requests:**

- allow custom runtime params on freebsd [\#81](https://github.com/saz/puppet-memcached/pull/81) ([sethlyons](https://github.com/sethlyons))
- Support Puppet v4 AIO \(Ruby 2.3.1\) [\#80](https://github.com/saz/puppet-memcached/pull/80) ([ghoneycutt](https://github.com/ghoneycutt))
- add support for freebsd [\#79](https://github.com/saz/puppet-memcached/pull/79) ([sethlyons](https://github.com/sethlyons))
- Add the ability to specify an array of extended options [\#77](https://github.com/saz/puppet-memcached/pull/77) ([dmart](https://github.com/dmart))
- custom template, min\_item\_size, factor supoort [\#74](https://github.com/saz/puppet-memcached/pull/74) ([michalrychlik](https://github.com/michalrychlik))
- Added support for unix\_socket in the sysconfig template [\#72](https://github.com/saz/puppet-memcached/pull/72) ([agitelzon](https://github.com/agitelzon))
- fix puppetlabs-firewall port parameter deprecation warning [\#70](https://github.com/saz/puppet-memcached/pull/70) ([crigertg](https://github.com/crigertg))
- add quote around tcp/udp ports so they are treated as strings [\#67](https://github.com/saz/puppet-memcached/pull/67) ([mmarseglia](https://github.com/mmarseglia))
- Solaris support for SMF management of memcached [\#63](https://github.com/saz/puppet-memcached/pull/63) ([matmannion](https://github.com/matmannion))

## [v2.8.1](https://github.com/saz/puppet-memcached/tree/v2.8.1) (2015-06-07)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v2.8.0...v2.8.1)

## [v2.8.0](https://github.com/saz/puppet-memcached/tree/v2.8.0) (2015-05-26)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v2.7.1...v2.8.0)

**Merged pull requests:**

- feature: Add possibilty to configure no listen\_ip. [\#60](https://github.com/saz/puppet-memcached/pull/60) ([andrekeller](https://github.com/andrekeller))
- Add a $service\_manage boolean [\#59](https://github.com/saz/puppet-memcached/pull/59) ([Spredzy](https://github.com/Spredzy))
- add support for logging to syslog. [\#56](https://github.com/saz/puppet-memcached/pull/56) ([mmarseglia](https://github.com/mmarseglia))
- Add ability to specify max object size. \(-I\) [\#55](https://github.com/saz/puppet-memcached/pull/55) ([mattkenn4545](https://github.com/mattkenn4545))
- Updates to run multiple instances of memcached. [\#54](https://github.com/saz/puppet-memcached/pull/54) ([dansajner](https://github.com/dansajner))

## [v2.7.1](https://github.com/saz/puppet-memcached/tree/v2.7.1) (2015-03-29)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v2.7.0...v2.7.1)

## [v2.7.0](https://github.com/saz/puppet-memcached/tree/v2.7.0) (2015-03-29)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v2.6.0...v2.7.0)

**Merged pull requests:**

- Convert @processorcount to string [\#53](https://github.com/saz/puppet-memcached/pull/53) ([jonhattan](https://github.com/jonhattan))
- Add windows support [\#52](https://github.com/saz/puppet-memcached/pull/52) ([bgrolleman](https://github.com/bgrolleman))
- Add support for custom and disabling of pidfiles. [\#51](https://github.com/saz/puppet-memcached/pull/51) ([jburnham](https://github.com/jburnham))
- Add support for large memory pages [\#50](https://github.com/saz/puppet-memcached/pull/50) ([joshuaspence](https://github.com/joshuaspence))

## [v2.6.0](https://github.com/saz/puppet-memcached/tree/v2.6.0) (2014-09-22)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v2.5.0...v2.6.0)

**Closed issues:**

- Support for hiera configuration? [\#45](https://github.com/saz/puppet-memcached/issues/45)
- Error on package removal with package\_ensure set to absent [\#42](https://github.com/saz/puppet-memcached/issues/42)

**Merged pull requests:**

- Replaced references to type\(\) function with is\_string\(\) for Puppet 3.7.x... [\#49](https://github.com/saz/puppet-memcached/pull/49) ([misterdorm](https://github.com/misterdorm))
- Add SASL support [\#48](https://github.com/saz/puppet-memcached/pull/48) ([gloppasglop](https://github.com/gloppasglop))
- Added option "auto\_removal" this option aim to enable or disable the -M ... [\#46](https://github.com/saz/puppet-memcached/pull/46) ([sxd](https://github.com/sxd))
- Releax the Puppet Enterprise requirement [\#44](https://github.com/saz/puppet-memcached/pull/44) ([hogepodge](https://github.com/hogepodge))
- Fix bug when `package_ensure` was set to `absent`. [\#43](https://github.com/saz/puppet-memcached/pull/43) ([riton](https://github.com/riton))
- Add SLES Support [\#41](https://github.com/saz/puppet-memcached/pull/41) ([globin](https://github.com/globin))

## [v2.5.0](https://github.com/saz/puppet-memcached/tree/v2.5.0) (2014-06-22)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v2.4.0...v2.5.0)

**Closed issues:**

- Autoreload service on config change [\#36](https://github.com/saz/puppet-memcached/issues/36)
- logfile setting in /etc/sysconfig/memcached in the case of Redhat OS [\#30](https://github.com/saz/puppet-memcached/issues/30)
- Add support for item size limit [\#29](https://github.com/saz/puppet-memcached/issues/29)

**Merged pull requests:**

- explicitly calling to\_s on parameters that could potentially be a numeri... [\#40](https://github.com/saz/puppet-memcached/pull/40) ([misterdorm](https://github.com/misterdorm))
- $logfile support for redhat [\#39](https://github.com/saz/puppet-memcached/pull/39) ([fizmat](https://github.com/fizmat))
- Enforce Linux line endings for \*.erb templates. [\#38](https://github.com/saz/puppet-memcached/pull/38) ([hdanes](https://github.com/hdanes))

## [v2.4.0](https://github.com/saz/puppet-memcached/tree/v2.4.0) (2014-02-10)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v2.1.0...v2.4.0)

**Closed issues:**

- memcached.log : "Could not open the pid file /var/run/memcached.pid for writing: Permission denied" [\#27](https://github.com/saz/puppet-memcached/issues/27)

**Merged pull requests:**

- Add firewall [\#34](https://github.com/saz/puppet-memcached/pull/34) ([ghoneycutt](https://github.com/ghoneycutt))
- Fix remaining deprecation warnings [\#26](https://github.com/saz/puppet-memcached/pull/26) ([judge-red](https://github.com/judge-red))
- Fix Puppet 3.2.x deprecation warnings [\#23](https://github.com/saz/puppet-memcached/pull/23) ([blkperl](https://github.com/blkperl))
- Implement Override the default size of each slab page [\#20](https://github.com/saz/puppet-memcached/pull/20) ([elgerpostema](https://github.com/elgerpostema))

## [v2.1.0](https://github.com/saz/puppet-memcached/tree/v2.1.0) (2013-02-01)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v2.0.4...v2.1.0)

**Merged pull requests:**

- New parameter '$install\_dev' to install development headers. [\#19](https://github.com/saz/puppet-memcached/pull/19) ([tPl0ch](https://github.com/tPl0ch))

## [v2.0.4](https://github.com/saz/puppet-memcached/tree/v2.0.4) (2012-11-06)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v2.0.3...v2.0.4)

**Merged pull requests:**

- Fix trailing characters from config file template [\#17](https://github.com/saz/puppet-memcached/pull/17) ([egon010](https://github.com/egon010))

## [v2.0.3](https://github.com/saz/puppet-memcached/tree/v2.0.3) (2012-10-19)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v2.0.1...v2.0.3)

**Closed issues:**

- memcache module is failing [\#15](https://github.com/saz/puppet-memcached/issues/15)
- No LICENSE file [\#13](https://github.com/saz/puppet-memcached/issues/13)
- rspec testsuite broken since 8053bb43 [\#11](https://github.com/saz/puppet-memcached/issues/11)
- max\_memory calculated value [\#4](https://github.com/saz/puppet-memcached/issues/4)

**Merged pull requests:**

- Backwards compatibility fix [\#16](https://github.com/saz/puppet-memcached/pull/16) ([derekhiggins](https://github.com/derekhiggins))
- Enrich memory variables: allow percents & add lock flag [\#14](https://github.com/saz/puppet-memcached/pull/14) ([garex](https://github.com/garex))
- Remove a trailing comma for compatibility with puppet 2.6 [\#12](https://github.com/saz/puppet-memcached/pull/12) ([branan](https://github.com/branan))
- Fix rake spec exit status [\#10](https://github.com/saz/puppet-memcached/pull/10) ([fcharlier](https://github.com/fcharlier))
- Support for Unix sockets and verbosity. [\#9](https://github.com/saz/puppet-memcached/pull/9) ([acceso](https://github.com/acceso))
- Using $::osfamily to make it work on RedHat derivatives [\#8](https://github.com/saz/puppet-memcached/pull/8) ([vaneldik](https://github.com/vaneldik))

## [v2.0.1](https://github.com/saz/puppet-memcached/tree/v2.0.1) (2012-05-04)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/v2.0.0...v2.0.1)

**Merged pull requests:**

- Adding fedora support [\#6](https://github.com/saz/puppet-memcached/pull/6) ([derekhiggins](https://github.com/derekhiggins))

## [v2.0.0](https://github.com/saz/puppet-memcached/tree/v2.0.0) (2012-01-20)

[Full Changelog](https://github.com/saz/puppet-memcached/compare/e181bc502e826b5bfebeeaca1d75f1dfd905d3a2...v2.0.0)

**Merged pull requests:**

- Simplify looking up user defaults from params namespace [\#3](https://github.com/saz/puppet-memcached/pull/3) ([bodepd](https://github.com/bodepd))
- CentOS/Redhat support [\#2](https://github.com/saz/puppet-memcached/pull/2) ([bramswenson](https://github.com/bramswenson))
- Refactor [\#1](https://github.com/saz/puppet-memcached/pull/1) ([bodepd](https://github.com/bodepd))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
