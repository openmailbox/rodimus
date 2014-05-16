require 'minitest/autorun'
require 'rodimus'

module Rodimus
  
  class TestStep < MiniTest::Unit::TestCase
    def test_streaming_rows
      test_string = "row 1\nrow 2"
      step = Object.new
      step.extend(Rodimus::Step)
      step.define_singleton_method(:transform) { |i| i }
      incoming = StringIO.new(test_string)
      outgoing = StringIO.new
      step.incoming = incoming
      step.outgoing = outgoing
      step.run
      outgoing.rewind
      assert_equal test_string, outgoing.read.chomp
    end

    def test_transformation_called
      test_string = "row 1\nrow 2"
      step = Class.new do
        include Rodimus::Step

        def process_row(row)
          row.upcase
        end
      end.new
      incoming = StringIO.new(test_string)
      outgoing = StringIO.new
      step.incoming = incoming
      step.outgoing = outgoing
      step.run
      outgoing.rewind
      assert_equal test_string.upcase, outgoing.read.chomp
    end
  end

end
