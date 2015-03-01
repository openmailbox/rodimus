# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rodimus/version'

Gem::Specification.new do |spec|
  spec.name                  = "rodimus"
  spec.version               = Rodimus::VERSION
  spec.authors               = ["Brandon Rice"]
  spec.email                 = ["brice84@gmail.com"]
  spec.summary               = "An ETL (Extract-Transform-Load) library that uses a forking process model for concurrency."
  spec.description           = "An ETL (Extract-Transform-Load) library that uses a forking process model for concurrency."
  spec.homepage              = "https://github.com/nevern02/rodimus"
  spec.license               = "MIT"
  spec.required_ruby_version = ">= 1.9.2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "faker", "~> 1.4"
end
