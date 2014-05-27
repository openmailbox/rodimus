require 'tempfile'
require 'csv'

class FileOutput
  include Rodimus::Step

  def initialize
    @outgoing = CSV.open('/tmp/connection_logging.csv', 'w')
  end

  def finalize
    puts "\nData written to #{outgoing.path}\n\n"
  end

  def process_row(row)
    JSON.parse(row).values
  end

end
