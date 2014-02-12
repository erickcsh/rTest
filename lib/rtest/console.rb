require 'singleton'
require 'colorize'

module RTest
  class Console
    include Singleton

    def display_leveled_message(level, message, color = nil)
      level.times { print "\t" }
      message = message.send(color) if color
      puts message
    end
  end
end
