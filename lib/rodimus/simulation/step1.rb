require 'json'

module Rodimus
  module Simulation
    
    class Step1 < Rodimus::Step
      def initialize(generator)
        super()
        @incoming = generator
      end

      def process_row(row)
        row.split.sort.to_json
      end
    end

  end
end
