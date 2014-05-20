require 'minitest/autorun'
require 'rodimus'

module Rodimus
  Rodimus.configure do |config|
    config.logger = Logger.new(nil)
  end

  class TestIO < IO
    attr_reader :history

    def initialize
      @history = []
    end

    def close; nil; end

    def puts(string)
      history << string
    end
  end
  
  class TestStep < MiniTest::Unit::TestCase
    def setup
      @test_string = "row 1\nrow 2"
      @incoming = StringIO.new(@test_string)
      @outgoing = TestIO.new
      @step = Object.new
      @step.extend(Rodimus::Step)
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

end
