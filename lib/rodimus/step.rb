module Rodimus

  module Step
    # The incoming data stream.  Can be anything that quacks like an IO
    attr_accessor :incoming

    # The outgoing data stream.  Can be anything that quacks like an IO
    attr_accessor :outgoing

    # Shared user-data accessible across all running transformation steps.
    # This is initialized by the Transformation when the step begins to run.
    attr_accessor :shared_data

    def close_descriptors
      [incoming, outgoing].reject(&:nil?).each do |descriptor|
        descriptor.close if descriptor.respond_to?(:close)
      end
    end

    # Override this for custom cleanup functionality.
    def finalize; end

    # Override this for custom output handling functionality per-row.
    def handle_output(transformed_row)
      outgoing.puts(transformed_row)
    end

    # Override this for custom transformation functionality
    def process_row(row)
      row.to_s
    end

    def run
      Rodimus.logger.info "Running #{self}"
      incoming.each do |row|
        transformed_row = process_row(row)
        handle_output(transformed_row)
      end
      finalize
      Rodimus.logger.info "Finished #{self}"
    ensure
      close_descriptors
    end

    def to_s
      "#{self.class} connected to input: #{incoming || 'nil'} and output: #{outgoing || 'nil'}"
    end
  end

end
