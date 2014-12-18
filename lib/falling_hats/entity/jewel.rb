module FallingHats
  module Entity
    module Jewel
      private
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
