require "gosu"
require "falling_hats/background/stage"
require "falling_hats/entity/player"
require "falling_hats/entity/hat"
require "falling_hats/entity/bullet"

module FallingHats
  module Scene
    class Stage
      def initialize(window)
        @window = window
        @background = Background::Stage.new(window)
        @font_size = @window.height / 10
        @font = Gosu::Font.new(@window, Gosu.default_font_name, @font_size)
        @player = Entity::Player.new(@window)
        @player.warp(@window.width / 2, @window.height * 0.9)
        @hats = []
        @bullets = []
        @fall_interval = 30
        @score = 0
        @radius = @window.width * 0.03
        @start_time = Time.now
        @time = 0.0
        @pause = false
        @pause_time = nil
      end

      def update
        return if @pause
        @time = "%0.1f" % (Time.now - @start_time)
        @player.update
        update_hats
        update_bullets
      end

      def update_hats
        if rand(@fall_interval) == 0
          hat = Entity::Hat.new(@window)
          hat.warp(rand(@window.width), 0)
          @hats << hat
        end

        @hats.select! do |hat|
          lived = true
          hat.update
          if hat.burn?
            lived = false
          elsif Gosu.distance(@player.x, @player.y, hat.x, hat.y) < @radius
            hat.burn!
            @score -= 5
            @score = 0 if @score < 0
          elsif hat.y > @window.height
            lived = false
          end
          @bullets.each do |bullet|
            if Gosu.distance(bullet.x, bullet.y, hat.x, hat.y) < @radius
              next if hat.burn?
              hat.burn!
              @score += 1
              @bullets.delete(bullet)
              break
            end
          end
          lived
        end
      end

      def update_bullets
        @bullets.select! do |bullet|
          bullet.update
          if (bullet.x < 0 or bullet.x > @window.width) and
              (bullet.y < 0 or bullet.y > @window.height)
            false
          else
            true
          end
        end
      end

      def draw
        @background.draw
        if @pause
          x = @window.width / 2 - @font_size
          y = @window.height / 2 - @font_size / 2
          @font.draw("pause", x, y, 10)
        end
        @player.draw
        @hats.each {|hat| hat.draw}
        @bullets.each {|bullet| bullet.draw}
        @font.draw("score: #{@score}", 0, 0, 1)
        @font.draw("time: #{@time}", 0, @font_size, 1)
      end

      def button_down(id)
        case id
        when Gosu::KbF,
             Gosu::KbZ,
             Gosu::MsWheelUp,
             Gosu::GpButton0,
             Gosu::GpButton1
          bullet = Entity::Bullet.new(@window, @player.angle)
          bullet.warp(@player.x, @player.y)
          @bullets << bullet
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
