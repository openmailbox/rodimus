module RbEtl

  module Step
    attr_accessor :incoming, :outgoing

    def run
      incoming.each do |row|
        outgoing.puts(transform(row))
      end
    end

    private

    # Override this for custom functionality
    def transform(row)
      row.to_s
    end
  end

end
