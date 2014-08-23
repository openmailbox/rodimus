require 'drb'

module Rodimus

  class Transformation
    include Observable
    include Observing # Transformations observe themselves for run hooks
    include RuntimeLogging

    attr_reader :drb_server, :ids, :steps

    # User-data accessible across all running steps.
    attr_reader :shared_data

    def initialize
      @steps = []
      @ids = []
      @shared_data = {} # TODO: This needs to be thread safe
      observers << self
    end

    def run
      notify(self, :before_run)
      @drb_server = DRb.start_service(nil, shared_data) unless using_threads?
      ids.clear
      prepare

      steps.each do |step|
        ids << in_parallel do
          step.shared_data = step_shared_data
          step.run
        end
        step.close_descriptors unless using_threads?
      end
    ensure
      cleanup
      notify(self, :after_run)
    end

    def to_s
      "#{self.class} with #{steps.length} steps"
    end

    private

    def cleanup
      if using_threads?
        ids.each { |t| t.join }
      else
        Process.waitall
        drb_server.stop_service
      end
    end
    
    def in_parallel 
      if using_threads?
        Thread.start { yield }
      else
        fork { yield }
      end
    end

    def prepare
      # [1, 2, 3, 4] => [1, 2], [2, 3], [3, 4]
      steps.inject do |first, second|
        read, write = IO.pipe
        first.outgoing = write
        second.incoming = read
        second
      end
    end

    def step_shared_data
      if using_threads?
        shared_data
      else
        DRb.start_service # service dies across forked process
        DRbObject.new_with_uri(drb_server.uri)
      end
    end

    def using_threads?
      Rodimus.configuration.use_threads
    end
  end

end
