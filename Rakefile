$: << File.expand_path('../lib', __FILE__)

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rodimus'

task :default => :test

Rake::TestTask.new do |t|
  t.libs.push 'lib'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

