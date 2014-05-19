module Rodimus

  module Step
    attr_accessor :incoming, :outgoing, :transformation
    attr_reader :shared_variables

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
      @shared_variables = DRbObject.new_with_uri(transformation.server.uri) if transformation
      incoming.each do |row|
        transformed_row = process_row(row)
        handle_output(transformed_row)
      end
      finalize
      Rodimus.logger.info "Finished #{self}"
    end

    def to_s
      "#{self.class} connected to input: #{incoming} and output: #{outgoing}"
    end
  end

end
