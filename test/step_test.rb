require 'minitest/autorun'
require 'rodimus'

Rodimus.configure do |config|
  config.logger = Logger.new(nil)
end

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

  def hook_test(hook_name, expected_call_count)
    @step.instance_eval do
      @hook_call_count = 0
      def hook_call_count; @hook_call_count; end
    end
    @step.define_singleton_method(hook_name) { @hook_call_count += 1 }

    assert_equal 0, @step.hook_call_count
    @step.run
    assert_equal expected_call_count, @step.hook_call_count
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

  def test_after_row_hook
    hook_test(:after_row_test, @test_string.split("\n").length)
  end

  def test_after_run_hook
    hook_test(:after_run_test, 1)
  end

  def test_before_row_hook
    hook_test(:before_row_test, @test_string.split("\n").length)
  end

  def test_before_run_hook
    hook_test(:before_run_test, 1)
  end
end
