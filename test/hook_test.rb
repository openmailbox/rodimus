require 'minitest/autorun'
require 'rodimus'

module Rodimus

  class TestHook < MiniTest::Unit::TestCase
    def setup
      @hookable = Class.new do
        attr_reader :called
      end.new
    end

    def test_before_run_hook_discovery
      @hookable.instance_eval { def before_run_test; @callable = true; end }
      assert_includes Hook.before_run_hooks(@hookable), :before_run_test
    end

    def test_after_run_hook_discovery
      @hookable.instance_eval { def after_run_test; @callable = true; end }
      assert_includes Hook.after_run_hooks(@hookable), :after_run_test
    end

    def test_before_row_hook_discovery
      @hookable.instance_eval { def before_row_test; @callable = true; end }
      assert_includes Hook.before_row_hooks(@hookable), :before_row_test
    end

    def test_after_row_hook_discovery
      @hookable.instance_eval { def after_row_test; @callable = true; end }
      assert_includes Hook.after_row_hooks(@hookable), :after_row_test
    end
  end

end
