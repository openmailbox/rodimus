require 'tempfile'
require 'csv'

class FileOutput < Rodimus::Step
  def initialize(suffix = nil)
    super
    @suffix = suffix ? "_#{suffix}" : ''
  end

  def before_run_set_output
    filename = "/tmp/connection_logging#{@suffix}.csv"
    @outgoing = CSV.open(filename , "w")
  end

  def finalize
    puts "\nData written to #{outgoing.path}\n\n"
  end

  def process_row(row)
    JSON.parse(row).values
  end
end
