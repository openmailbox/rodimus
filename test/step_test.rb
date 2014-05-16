require 'minitest/autorun'
require 'rodimus'

module Rodimus
  
  class TestStep < MiniTest::Unit::TestCase
    def setup
      @test_string = "row 1\nrow 2"
      @incoming = StringIO.new(@test_string)
      @outgoing = StringIO.new
    end

    def test_streaming_rows
      step = Object.new
      step.extend(Rodimus::Step)
      step.incoming = @incoming
      step.outgoing = @outgoing
      step.run
      @outgoing.rewind
      assert_equal @test_string, @outgoing.read.chomp
    end

    def test_transformation_called
      step = Class.new do
        include Rodimus::Step

        def process_row(row)
          row.upcase
        end
      end.new
      step.incoming = @incoming
      step.outgoing = @outgoing
      step.run
      @outgoing.rewind
      assert_equal @test_string.upcase, @outgoing.read.chomp
    end
  end

end
