require 'logger'

module Rodimus

  class Configuration
    attr_accessor :logger

    # Set to true for extra output with step performance details
    attr_accessor :benchmarking

    # Use threads for concurrency instead of forking processes.
    # Automatically set to true for JRuby and Rubinius
    attr_accessor :use_threads

    def initialize
      @logger = Logger.new(STDOUT)
      @benchmarking = false
      @use_threads = ['jruby', 'rbx'].include?(RUBY_ENGINE)
    end
  end

end
