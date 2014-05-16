module RbEtl

  module Step
    attr_accessor :incoming, :outgoing

    def run
      incoming.each do |row|
        new_row = transform(row)
        outgoing.puts(new_row)
      end
      outgoing.close
    end

    private

    # Override this for custom functionality
    def transform(row)
      row.to_s
    end
  end

end
