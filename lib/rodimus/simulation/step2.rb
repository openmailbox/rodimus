require 'json'

module Rodimus
  module Simulation

    class Step2 < Rodimus::Step
      def before_run_set_output
        fd = IO.sysopen('/dev/null', 'w')
        @outgoing = IO.new(fd, 'w')
      end

      def process_row(row)
        row = JSON.parse(row)
        row.map { |i| i.split('').sort.join('') }
      end
    end

  end
end
