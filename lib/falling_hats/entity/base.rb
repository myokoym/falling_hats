module FallingHats
  module Entity
    module Base
      attr_reader :x, :y

      def initialize(window)
        @window = window
        @x = 0
        @y = 0
      end

      def warp(x, y)
        @x = x
        @y = y
      end
    end
  end
end
