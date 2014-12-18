require "gosu"
require "falling_hats/entity/player"
require "falling_hats/entity/hat"

module FallingHats
  module Scene
  class Stage
    def initialize(window)
      @window = window
      @font_size = @window.height / 10
      @font = Gosu::Font.new(@window, Gosu.default_font_name, @font_size)
      @player = Entity::Player.new(@window, @window.width / 2, @window.height * 0.9)
      @hats = []
      @fall_interval = 30
      @score = 0
      @start_time = Time.now
      @time = 0.0
      @pause = false
      @pause_time = nil
    end

    def update
      return if @pause
      @time = "%0.1f" % (Time.now - @start_time)
      if rand(@fall_interval) == 0
        @hats << Entity::Hat.new(@window, rand(@window.width), 0)
      end
      @player.update
      @hats.each do |ball|
        ball.update
        if Gosu.distance(@player.x, @player.y, ball.x, ball.y) < @window.width / 20
          @score += 1
          @hats.delete(ball)
        end
      end
      @hats.reject! {|ball| ball.y > @window.height}
    end

    def draw
      if @pause
        x = @window.width / 2 - @font_size
        y = @window.height / 2 - @font_size / 2
        @font.draw("pause", x, y, 10)
      end
      @player.draw
      @hats.each {|hat| hat.draw}
      @font.draw("score: #{@score}", 0, 0, 1)
      @font.draw("time: #{@time}", 0, @font_size, 1)
    end

    def button_down(id)
      case id
      when Gosu::KbSpace
        if @pause
          @start_time = @start_time + (Time.now - @pause_time)
          @pause = false
        else
          @pause = true
          @pause_time = Time.now
        end
      when Gosu::KbEscape
        @window.return_title
      end
    end
  end
  end
end
