require_relative "messages"
require_relative "game_engine"
require_relative "extra_methods"
module PaitinHangman
class Game
  include SimpleMethods
  # =>The initialize instantiates a new Message object & calls an instant method
  def initialize
    Message.game_intro
    verify_name_integrity
    puts "Hi #{@name}, Select a mode"
    play(@name)
  end
end
end
