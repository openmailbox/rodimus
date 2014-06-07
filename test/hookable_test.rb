require 'minitest/autorun'
require 'rodimus'

class TestHookable < MiniTest::Unit::TestCase
  def setup
    @hookable = Object.new
    @hookable.extend(Rodimus::Hookable)
  end

  def test_discovered_hooks
    @hookable.instance_eval { def before_run_test; end }
    assert_includes @hookable.discovered_hooks(:before_run), :before_run_test
  end
end
