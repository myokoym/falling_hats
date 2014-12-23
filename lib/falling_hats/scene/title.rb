require "gosu"
require "falling_hats/background/stage"

module FallingHats
  module Scene
    class Title
      def initialize(window)
        @window = window
        @background = Background::Stage.new(window)

        @title_font_size = @window.width / 5
        @title = Gosu::Image.from_text(@window,
                                       "Falling Hats",
                                       "Monospace",
                                       @title_font_size,
                                       0,
                                       @window.width,
                                       :center)

        @description_font_size = @window.width / 10
        @description = Gosu::Image.from_text(@window,
                                             "press Enter",
                                             "Monospace",
                                             @description_font_size,
                                             0,
                                             @window.width,
                                             :center)

        @color = Gosu::Color::BLUE
        @color_movement = 1
      end

      def update
        @color.hue += @color_movement
        @color_movement = 0 if @color_movement == 360
      end

      def draw
        @background.draw
        @title.draw(0, @window.height * 0.3,
                    1,
                    1.0, 1.0,
                    @color)
        return if Time.now.sec % 2 == 0
        @description.draw(0, @window.height * 0.6,
                          1,
                          1.0, 1.0,
                          Gosu::Color::WHITE)
      end

      def button_down(id)
        case id
        when Gosu::KbReturn, Gosu::KbEnter
          @window.start
        when Gosu::KbEscape
          @window.exit
        end
      end
    end
  end
end
