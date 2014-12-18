require "gosu"

module FallingHats
  module Entity
    class Hat
      attr_reader :x, :y
      def initialize(window, x, y, options={})
        @window = window
        @x = x
        @y = y
        @radius   = options[:radius]   || @window.width * 0.03
        @movement = options[:movement] || @window.width * 0.005
        @color    = options[:color]    || Gosu::Color::GRAY
        @z_order  = options[:z_order]  || 1
      end

      def update
        @y += @movement
      end

      def draw
        draw_crown
        draw_ribbon
        draw_edge
      end

      private
      def draw_crown
        x1 = @x - @radius * 0.8
        y1 = @y - @radius * 0.7
        x2 = @x + @radius * 0.8
        y2 = @y + @radius * 0.5
        draw_rectangle(x1, y1, x2, y2, @color)
      end

      def draw_ribbon
        x1 = @x - @radius * 0.75
        y1 = @y - @radius * 0.1
        x2 = @x + @radius * 0.75
        y2 = @y + @radius * 0.4
        draw_rectangle(x1, y1, x2, y2, Gosu::Color::BLACK)
      end

      def draw_edge
        x1 = @x - @radius * 1.1
        y1 = @y + @radius * 0.4
        x2 = @x + @radius * 1.1
        y2 = @y + @radius * 0.7
        draw_rectangle(x1, y1, x2, y2, @color)
      end

      def draw_rectangle(x1, y1, x2, y2, color)
        @window.draw_quad(x1, y1, color,
                          x2, y1, color,
                          x2, y2, color,
                          x1, y2, color,
                          @z_order)
      end
    end
  end
end
