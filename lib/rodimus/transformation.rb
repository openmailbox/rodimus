module Rodimus

  class Transformation
    attr_reader :steps

    def initialize
      @steps = []
    end

    def run
      prepare

      steps.each do |step|
        fork do
          step.run
        end
        step.incoming && step.incoming.close
        step.outgoing && step.outgoing.close
      end

      Process.waitall
    end

    private

    def prepare
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
