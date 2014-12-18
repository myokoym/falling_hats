require "gosu"

module FallingHats
  module Entity
    class Player
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

      def draw_body
        draw_upper_body
        draw_lower_body
      end

      def draw_upper_body
        x1 = @x - @radius * 0.5
        y1 = @y - @radius * 0.7
        x2 = @x + @radius * 0.5
        y2 = @y - @radius * 0.7
        x3 = @x + @radius
        y3 = @y - @radius * 0.1
        x4 = @x - @radius
        y4 = @y - @radius * 0.1
        @window.draw_quad(x1, y1, @color,
                          x2, y2, @color,
                          x3, y3, @color,
                          x4, y4, @color,
                          @z_order)
      end

      def draw_lower_body
        x1 = @x - @radius
        y1 = @y
        x2 = @x + @radius
        y2 = @y
        x3 = @x
        y3 = @y + @radius
        @window.draw_triangle(x1, y1, @color,
                              x2, y2, @color,
                              x3, y3, @color,
                              @z_order)
      end
    end
  end
end
