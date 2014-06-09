require 'minitest/autorun'
require 'rodimus'

class TestObserving < MiniTest::Unit::TestCase
  def setup
    @observer = Class.new do
      include Rodimus::Observing

      attr_reader :called

      def initialize
        @called = false
      end

      def before_run_test
        @called = true
      end
    end.new
  end

  def test_hook_discovery
    refute @observer.called
    @observer.on_notify(self, :before_run)
    assert @observer.called
  end
end
