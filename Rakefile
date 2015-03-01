$: << File.expand_path('../lib', __FILE__)

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rodimus'

task :default => :test

Rake::TestTask.new do |t|
  t.libs.push 'lib'
  t.libs.push 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

desc 'Run a simulation on a large data set'
task :simulate, :rows do |t, args|
  require 'rodimus/simulation'
  rows = (args[:rows] || 50_000).to_i
  Rodimus::Simulation.run(rows)
end
