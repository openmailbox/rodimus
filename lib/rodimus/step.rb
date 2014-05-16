module Rodimus

  module Step
    attr_accessor :incoming, :outgoing

    def run
      Rodimus.logger.info "Running #{self}"
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

    private

    # Override this for custom functionality
    def finalize; end

    # Override this for custom functionality
    def handle_output(transformed_row)
      outgoing.puts(transformed_row)
    end

    # Override this for custom functionality
    def process_row(row)
      row.to_s
    end
  end

end
