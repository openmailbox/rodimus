require 'faker'
require 'forwardable'

module Rodimus
  module Simulation

    class RowGenerator
      extend Forwardable

      def_delegator :@rows, :each

      def initialize(count = 50_000)
        @count = count
        @rows = count.times.map { |i| Faker::Lorem.sentence }
      end
    end

  end
end
