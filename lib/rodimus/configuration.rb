require 'logger'

module Rodimus

  class Configuration
    attr_accessor :logger, :benchmarking, :use_threads

    def initialize
      @logger = Logger.new(STDOUT)
      @benchmarking = false
      @use_threads = ['jruby', 'rbx'].include?(RUBY_ENGINE)
    end
  end

end
