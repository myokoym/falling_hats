require "falling_hats/z_order"

module FallingHats
  module Entity
    class Bullet
      include Base
      include Jewel

      def initialize(window, angle=0)
        super(window)
        @radius = @window.width * 0.01
        @movement = @window.width * 0.015
        @color = Gosu::Color::RED
        @angle = angle
        @z_order = ZOrder::ENTITY
      end

      def move
        @x += Gosu.offset_x(@angle, @movement)
        @y += Gosu.offset_y(@angle, @movement)
      end

      def update
        move
        @movement *= 0.99
      end

      def draw
        draw_body
      end
    end
  end
end
