require 'logger'

module Rodimus

  class Configuration
    attr_accessor :logger, :benchmarking

    def initialize
      @logger = Logger.new(STDOUT)
      @benchmarking = false
    end
  end

end
