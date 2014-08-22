require 'rodimus'
require_relative 'log_input'
require_relative 'parse_connection'
require_relative 'file_output'

Rodimus.configure do |config|
  config.benchmarking = true
end

log = File.expand_path('../rails_example.log', __FILE__)
t = Rodimus::Transformation.new
step1 = LogInput.new(log)
step2 = ParseConnection.new
step3 = FileOutput.new
t.steps << step1
t.steps << step2
t.steps << step3
t.run

puts "Transformation complete!"
