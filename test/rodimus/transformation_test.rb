require 'test_helper'

module Rodimus

  class TestTransformation < MiniTest::Test
    Rodimus.configure do |config|
      config.logger = Logger.new(nil)
    end

    def test_parallel_steps
      incoming = StringIO.new
      transformation = Transformation.new
      number_of_steps = 2 + rand(5)
      number_of_steps.times do 
        transformation.steps << Rodimus::Step.new
      end
      transformation.steps.first.incoming = incoming
      transformation.run
      assert_equal(transformation.steps.count, transformation.ids.count)
    end
  end

end
