require 'rodimus/simulation/row_generator'
require 'rodimus/simulation/step1'
require 'rodimus/simulation/step2'


module Rodimus
  module Simulation
    def self.run(rows = 50_000)
      Rodimus.configure do |config|
        config.benchmarking = true
      end

      transformation = Transformation.new
      Rodimus.logger.info "Generating data."
      generator = RowGenerator.new(rows)
      step1 = Step1.new(generator)
      step2 = Step2.new

      transformation.steps << step1
      transformation.steps << step2

      Rodimus.logger.info "Running transformation."
      transformation.run
    end
  end
end
