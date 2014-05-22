require 'drb'

module Rodimus

  class Transformation
    attr_reader :drb_server, :pids, :steps

    # User-data accessible across all running steps.
    attr_reader :shared_data

    def initialize
      @steps = []
      @pids = []
      @shared_data = {} # TODO: This needs to be thread safe
    end

    def run
      @drb_server = DRb.start_service(nil, shared_data)
      pids.clear
      prepare

      steps.each do |step|
        pids << fork do
          DRb.start_service # the parent DRb thread dies across the fork
          step.shared_data = DRbObject.new_with_uri(drb_server.uri)
          step.run
        end
        step.close_descriptors
      end
    ensure
      Process.waitall
      drb_server.stop_service
    end

    def to_s
      "#{self.class} with #{steps.length} steps"
    end

    private

    def prepare
      Rodimus.logger.info "Preparing #{self}..."
      # [1, 2, 3, 4] => [1, 2], [2, 3], [3, 4]
      steps.inject do |first, second|
        read, write = IO.pipe
        first.outgoing = write
        second.incoming = read
        second
      end
    end
  end

end
