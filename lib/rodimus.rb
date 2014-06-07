require 'rodimus/configuration'
require 'rodimus/hookable'
require 'rodimus/step'
require 'rodimus/transformation'
require 'rodimus/version'

module Rodimus
  $SAFE = 1 # Because we're using DRb

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
