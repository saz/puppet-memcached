source ENV['GEM_SOURCE'] || 'https://rubygems.org'

def location_for(place, fake_version = nil)
  if place =~ %r{^(git[:@][^#]*)#(.*)}
    [fake_version, { git: Regexp.last_match(1), branch: Regexp.last_match(2), require: false }].compact
  elsif place =~ %r{/^file:\/\/(.*)/}
    ['>= 0', { path: File.expand_path(Regexp.last_match(1)), require: false }]
  else
    [place, { require: false }]
  end
end

group :test do
  gem 'json_pure', '<= 2.0.1',                                      require: false if RUBY_VERSION < '2.0.0'
  gem 'metadata-json-lint',                                         require: false
  gem 'puppet-blacksmith',                                          require: false
  gem 'puppet-lint-absolute_classname-check',                       require: false
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check',  require: false
  gem 'puppet-lint-leading_zero-check',                             require: false
  gem 'puppet-lint-trailing_comma-check',                           require: false
  gem 'puppet-lint-unquoted_string-check',                          require: false
  gem 'puppet-lint-variable_contains_upcase',                       require: false
  gem 'puppet-lint-version_comparison-check',                       require: false
  gem 'puppetlabs_spec_helper',                                     require: false
  gem 'rspec-its',                                                  require: false
  gem 'rspec-puppet',                                               require: false, git: 'https://github.com/rodjek/rspec-puppet.git'
  gem 'rspec-puppet-facts',                                         require: false
  gem 'rspec-puppet-utils',                                         require: false
  gem 'rubocop-rspec', '~> 1.5',                                    require: false if RUBY_VERSION >= '2.2.0'
  gem 'voxpupuli-release',                                          require: false, git: 'https://github.com/voxpupuli/voxpupuli-release-gem.git'
end

group :development do
  gem 'guard-rake',   require: false
  gem 'travis',       require: false
  gem 'travis-lint',  require: false
end

group :system_tests do
  if (beaker_version = ENV['BEAKER_VERSION'])
    gem 'beaker', *location_for(beaker_version)
  end
  if (beaker_rspec_version = ENV['BEAKER_RSPEC_VERSION'])
    gem 'beaker-rspec', *location_for(beaker_rspec_version)
  else
    gem 'beaker-rspec', require: false
  end
  gem 'beaker-puppet_install_helper', require: false
end

if (facterversion = ENV['FACTER_GEM_VERSION'])
  gem 'facter', facterversion.to_s, require: false, groups: [:test]
else
  gem 'facter', require: false, groups: [:test]
end

puppetversion = ENV['PUPPET_VERSION'].nil? ? '~> 4.0' : ENV['PUPPET_VERSION'].to_s
gem 'puppet', puppetversion, require: false, groups: [:test]

# vim: syntax=ruby
