begin
  require "gosu"
rescue LoadError
  $stderr.puts(<<-END_OF_MESSAGE)
LoadError: #{$!.message}. Please try `gem install gosu`.
If you are using Linux, please see https://github.com/jlnr/gosu/wiki/Getting-Started-on-Linux
  END_OF_MESSAGE
  exit(false)
end
require "falling_hats/scene/title"
require "falling_hats/scene/stage"

module FallingHats
  class Game < Gosu::Window
    class << self
      def run
        new.show
      end
    end

    def initialize(width=640, height=480, fullscreen=false)
      super(width, height, fullscreen)
      self.caption = "Falling Hats"
      @stage = Scene::Title.new(self)
    end

    def update
      @stage.update
    end

    def draw
      @stage.draw
    end

    def button_down(id)
      @stage.button_down(id)
    end

    def start
      @stage = Scene::Stage.new(self)
    end

    def return_title
      @stage = Scene::Title.new(self)
    end

    def exit
      close
    end
  end
end
