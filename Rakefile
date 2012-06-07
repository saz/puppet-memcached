require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'

task :default => [:spec]

desc "Run all module spec tests (Requires rspec-puppet gem)"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['--color']
  # ignores fixtures directory.
  t.pattern = 'spec/{classes,defines,unit}/**/*_spec.rb'
end

desc "Build package"
task :build do
  system("puppet-module build")
end

