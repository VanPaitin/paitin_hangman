require_relative "levels"
module PaitinHangman
class GameResumption
  def initialize
    @all_games = YAML.load_stream(File.open("games.yml", "a+"))
    puts "Enter the name you used to store the game"
    name = gets.chomp.upcase
    @saved_game = @all_games.select do |game|
      game.player_name == name
    end
    initialize_cont(name)
  end

  def initialize_cont(name)
    if @saved_game.empty?
      puts "You have no saved game with that name".red
      puts "START A NEW GAME INSTEAD".yellow
      exit
    end
    puts "Here are the saved games found for #{name}\n\n"
    print_function
    choice_integrity
  end

  def choice_integrity
    puts "Now enter the number for the game you want to play"
    @choice = gets.chomp.to_i
    until @choice > 0 && @choice <= @saved_game.length
      puts "Enter a number that has a game please"
      @choice = gets.chomp.to_i
    end
    @choice -= 1
    load_properties
  end

  def load_properties
    game_object = @saved_game[@choice]
    @name = game_object.player_name
    @misses = game_object.misses
    @right_guesses = game_object.right_guesses
    @chances = game_object.chances
    @word_control = game_object.word_control
    @game_word = game_object.game_word
    load_properties_cont(game_object)
  end

  def delete_game
    @all_games.delete(@saved_game[@choice])
    File.open("games.yml", "r+") { |data| YAML.dump(@all_games, data) }
  end

  def load_properties_cont(game_object)
    count = game_object.count
    #delete_game
    Saved.new(@name, @chances, @word_control, @game_word,
              @misses, @right_guesses, count).trials(@chances)
  end

  def print_function
    @saved_game.length.times do |index|
      print "#{index + 1}.\t"
      puts @saved_game[index], "\n"
    end
  end
end

class Saved < Levels
  def initialize(name, chances, word_control, game_word, misses, right_guesses,
                 count)
    @player_name = name
    @chances = chances
    @word_control = word_control
    @game_word = game_word
    @misses = misses
    @right_guesses = right_guesses
    @count = count
  end

  def trials(chances)
    setup
    chances.times do |counter|
      @counter = counter
      verify_guess
      compare_guess
      win_game(chances, counter)
    end
    end_game
  end

  def setup
    puts "Now, continue playing..."
    puts @word_control.gsub("_", "__ ").upcase
  end
end
end