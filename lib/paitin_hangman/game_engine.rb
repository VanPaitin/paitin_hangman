require_relative "messages"
require_relative "levels"
require_relative "extra_methods"
# => This class only ensures the smooth transfer of control to the levels
module PaitinHangman
class Computer
  def initialize(name)
    @id = name
    Message.level_choice
    level_integrity
    level
  end

  def level_integrity
    @choice = STDIN.gets.chomp
    until @choice == "1" || @choice == "2" || @choice == "3"
      puts "Please press either '1', '2' or '3'"
      @choice = STDIN.gets.chomp
    end
  end

  def level
    case @choice
    when "1" then Levels.new(@id, 4, 8, 10)
    when "2" then Levels.new(@id, 9, 12, 12)
    when "3" then Levels.new(@id, 13, 25, 15)
    end
  end
end

class Player < Computer
  include SimpleMethods
  def initialize(name)
    @player1 = name
    get_friend_name
    @player2 = @name
    puts "Hello, #{@player1} and #{@player2}, who will like to challenge"
    game
  end

  def get_friend_name
    puts "Hi #{@player1}, what is the name of your friend"
    verify_name_integrity
  end

  def game
    verify_name_integrity
    game_player until @name == @player1 || @name == @player2
    @other_player = @player2 if @name == @player1
    @other_player = @player1 if @name == @player2
    Message.level_choice
    select_level
  end

  def game_player
    puts "Please enter one of your names: #{@player1} or #{@player2}"
    verify_name_integrity
  end

  def select_level
    level_integrity
    case @choice
    when "1" then Levels.new(@other_player, 4, 8, 8, @name)
    when "2" then Levels.new(@other_player, 9, 12, 10, @name)
    when "3" then Levels.new(@other_player, 13, 25, 12, @name)
    end
  end
end
end
