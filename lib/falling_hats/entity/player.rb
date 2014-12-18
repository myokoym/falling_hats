require "gosu"
require "falling_hats/entity/jewel"

module FallingHats
  module Entity
    class Player
      include Jewel

      attr_reader :x, :y, :angle
      def initialize(window, x, y, options={})
        @window = window
        @x = x
        @y = y
        @radius   = options[:radius]   || @window.width * 0.03
        @movement = options[:movement] || @window.width * 0.005
        @color    = options[:color]    || Gosu::Color::RED
        @z_order  = options[:z_order]  || 1
        @angle = 0
      end

      def update
        if move_to_left?
          move_to_left
        elsif move_to_right?
          move_to_right
        else
          @angle = 0
        end
      end

      def draw
        @window.rotate(@angle, @x, @y) do
          draw_body
        end
      end

      private
      def move_to_left
        @x -= @movement
        @angle -= 1
        @angle = -30 if @angle < -30
      end

      def move_to_right
        @x += @movement
        @angle += 1
        @angle = 30 if @angle > 30
      end

      def move_to_left?
        @window.button_down?(Gosu::KbLeft) or
         @window.button_down?(Gosu::MsLeft) or
         @window.button_down?(Gosu::GpLeft) or
         @window.button_down?(Gosu::GpButton4)
      end

      def move_to_right?
        @window.button_down?(Gosu::KbRight) or
         @window.button_down?(Gosu::MsRight) or
         @window.button_down?(Gosu::GpRight) or
         @window.button_down?(Gosu::GpButton5)
      end
    end
  end
end
