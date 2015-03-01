require 'rodimus/configuration'
require 'rodimus/observable'
require 'rodimus/observing'
require 'rodimus/benchmark'
require 'rodimus/runtime_logging'
require 'rodimus/step'
require 'rodimus/buffered_step'
require 'rodimus/transformation'
require 'rodimus/version'

module Rodimus
  class << self
    attr_accessor :configuration
  end
  self.configuration = Configuration.new

  def self.configure
    yield configuration
  end

  def self.logger
    configuration.logger
  end

  unless Rodimus.configuration.use_threads
    $SAFE = 1 # Because we're using DRb
  end
end
