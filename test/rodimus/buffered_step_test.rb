require 'test_helper'

class TestBufferedStep < MiniTest::Test
  attr_reader :incoming, :outgoing, :step

  def setup
    rows      = "row 1\nrow 2\nrow 3"
    @incoming = StringIO.new(rows)
    @outgoing = TestIO.new
    @step     = Rodimus::BufferedStep.new
    
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
    step.buffer_size     = 2
    expected_write_count = 2

    step.run

    assert_equal expected_write_count, outgoing.history.length
  end
end
