require 'rodimus/configuration'
require 'rodimus/step'
require 'rodimus/step_collection'
require 'rodimus/transformation'
require 'rodimus/version'

module Rodimus
  $SAFE = 1

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
end
