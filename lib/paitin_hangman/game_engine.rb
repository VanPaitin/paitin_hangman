require_relative "messages"
require_relative "levels"
require_relative "extra_methods"
# => This class only ensures the smooth transfer of control to the levels
module PaitinHangman
class Computer
  def initialize
    Message.level_choice
  end

  def level_integrity(name)
    choice = gets.chomp
    until choice == "1" || choice == "2" || choice == "3"
      puts "Please press either '1', '2' or '3'"
      choice = STDIN.gets.chomp
    end
    level(choice, name)
  end

  def level(choice, name)
    case choice
    when "1" then Levels.new(name, 4, 8, 10)
    when "2" then Levels.new(name, 9, 12, 12)
    when "3" then Levels.new(name, 13, 25, 15)
    end
  end
end

class Player
  include SimpleMethods

  def first_player_name(name)
    player1 = name
    get_friend_name(player1)
  end

  def get_friend_name(player1)
    puts "Hi #{player1}, what is the name of your friend"
    player2 = verify_name_integrity
    puts "Hello, #{player1} and #{player2}, who will like to challenge"
    game(player1, player2)
  end

  def game(player1, player2)
    begin 
      puts "Please enter one of your names: #{player1} or #{player2}"
      name = verify_name_integrity
    end until name == player1 || name == player2
    other_player = player2 if name == player1
    other_player = player1 if name == player2
    Message.level_choice
    level_integrity(name, other_player)
  end

  def level_integrity(name, other_player)
    choice = gets.chomp
    until choice == "1" || choice == "2" || choice == "3"
      puts "Please press either '1', '2' or '3'"
      choice = STDIN.gets.chomp
    end
    select_level(choice, name, other_player)
  end

  def select_level(choice, name, other_player)
    case choice
    when "1" then Levels.new(other_player, 4, 8, 10, name)
    when "2" then Levels.new(other_player, 9, 12, 12, name)
    when "3" then Levels.new(other_player, 13, 25, 15, name)
    end
  end

end
end
