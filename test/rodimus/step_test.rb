require 'test_helper'

class TestStep < MiniTest::Test
  def setup
    @test_string = "row 1\nrow 2"
    @incoming = StringIO.new(@test_string)
    @outgoing = TestIO.new
    @step = Rodimus::Step.new
    @step.incoming = @incoming
    @step.outgoing = @outgoing
  end

  def test_streaming_rows
    @step.run
    assert_equal @test_string, @outgoing.history.join
  end

  def test_process_row
    @step.define_singleton_method(:process_row) do |row|
      row.upcase
    end
    @step.run
    assert_equal @test_string.upcase, @outgoing.history.join
  end
end
