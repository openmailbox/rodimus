require 'minitest/autorun'
require 'rodimus'

class TestIO < IO # Because we can't read closed StringIOs
  attr_reader :history

  def initialize
    @history = []
  end

  def close; nil; end

  def puts(string)
    history << string
  end
end

class TestBufferedStep < MiniTest::Unit::TestCase
  attr_reader :rows, :incoming, :outgoing, :step

  def setup
    @rows = "row 1\nrow 2\nrow 3"
    @incoming = StringIO.new(rows)
    @outgoing = TestIO.new
    @step = Rodimus::BufferedStep.new
    
    step.incoming = incoming
    step.outgoing = outgoing
  end

  def test_buffering_rows
    step.buffer_size     = 3
    expected_write_count = 1 # writing 3 rows

    step.run

    assert_equal expected_write_count, outgoing.history.length 
  end

  def test_flushing_rows
    step.buffer_size     = 4
    expected_write_count = 1

    step.run

    assert_equal expected_write_count, outgoing.history.length
  end
end
