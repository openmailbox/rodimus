require 'tempfile'
require 'csv'

class FileOutput < Rodimus::Step
  def before_run_set_output
    @outgoing = CSV.open('/tmp/connection_logging.csv', 'w')
  end

  def after_run_log_path
    puts "\nData written to #{outgoing.path}\n\n"
  end

  def process_row(row)
    JSON.parse(row).values
  end
end
