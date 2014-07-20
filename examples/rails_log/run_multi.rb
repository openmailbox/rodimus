require 'rodimus'
require_relative 'log_input'
require_relative 'parse_connection_multi'
require_relative 'file_output'

log = File.expand_path('../rails_example.log', __FILE__)
t = Rodimus::Transformation.new
step1 = LogInput.new(log)
step2 = ParseConnection.new('GET', 'POST', 'DEFAULT')
step2a_1 = FileOutput.new('GET')
step2b_1 = FileOutput.new('POST')
step2c_1 = FileOutput.new('DEFAULT')
t.steps << step1
t.steps << step2
t.steps << [[step2a_1], [step2b_1], [step2c_1]]
t.run

puts "Transformation complete!"
