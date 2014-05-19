require 'delegate'

module Rodimus

  class StepCollection < SimpleDelegator
    attr_reader :transformation

    def initialize(transformation)
      super([])
      @transformation = transformation
    end

    def <<(other)
      super(other)
      other.transformation = transformation
    end
  end

end
