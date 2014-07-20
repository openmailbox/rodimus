require 'json'

class ParseConnection < Rodimus::MultiOutputStep
  attr_reader :current_event

  def initialize(*verbs)
    @slots = verbs.map(&:downcase)
    super
  end

  def handle_output(row); nil; end

  def process_row(row)
    if row =~ /^Started/
      parse_new_connection(row)
    elsif row =~ /^Completed/
      parse_end_connection(row)

      outgoing_slot = @slots.index(current_event[:verb].downcase) || -1
      outgoing[outgoing_slot].puts(current_event.to_json) if outgoing[outgoing_slot]
    end
  end

  private

  def parse_new_connection(row)
    @current_event = {}
    match_data = row.match(/^Started (\w+) \"(.+)\" for (.+) at (.+)$/)
    current_event[:verb] = match_data[1]
    current_event[:route] = match_data[2]
    current_event[:ip] = match_data[3]
    current_event[:time] = match_data[4]
  end

  def parse_end_connection(row)
    match_data = row.match(/^Completed ([0-9]+)/)
    current_event[:response] = match_data[1]
  end
end
