require 'logger'

module Rodimus

  class Configuration
    attr_accessor :logger

    def initialize
      @logger = Logger.new(STDOUT)
    end
  end

end
