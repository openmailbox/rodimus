require 'minitest/autorun'
require 'rodimus'

module Rodimus
  Rodimus.configure do |config|
    config.logger = Logger.new(nil)
  end
  
  class TestStep < MiniTest::Unit::TestCase
    def setup
      @test_string = "row 1\nrow 2"
      @incoming = StringIO.new(@test_string)
      @outgoing = StringIO.new
      @tested_io = @outgoing.dup # Because outgoing is auto-closed
    end

    def test_streaming_rows
      step = Object.new
      step.extend(Rodimus::Step)
      step.incoming = @incoming
      step.outgoing = @outgoing
      step.run
      @tested_io.rewind
      assert_equal @test_string, @tested_io.read.chomp
    end

    def test_process_row
      step = Class.new do
        include Rodimus::Step

        def process_row(row)
          row.upcase
        end
      end.new
      step.incoming = @incoming
      step.outgoing = @outgoing
      step.run
      @tested_io.rewind
      assert_equal @test_string.upcase, @tested_io.read.chomp
    end
  end

end
