require "gosu"

module FallingHats
  module Background
    class Stage
      def initialize(window)
        @window = window
        @night_color = Gosu::Color::BLACK
        @daytime_color = Gosu::Color.new(0xff003366)
        @x1 = @window.width * -2
        @y1 = 0
        @x2 = @window.width * 8
        @y2 = @window.height
      end

      def draw
        @window.draw_quad(@x1, @y1, @night_color,
                          @x2, @y1, @night_color,
                          @x2, @y2, @daytime_color,
                          @x1, @y2, @daytime_color,
                          0)  # TODO: use constant. e.g.) ZOrder::BACK_GROUND
      end
    end
  end
end
