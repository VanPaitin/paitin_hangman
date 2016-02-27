require "colorize"
require "io/console"
require "yaml"
require_relative "game_play"
require_relative "extra_methods"
require_relative "messages"
require_relative "game_data"
module PaitinHangman
class Levels
  include SimpleMethods
  def initialize(player, min, max, chances, another_player = nil)
    @misses = []
    @right_guesses = []
    initialize_specs(player, min, max, chances, another_player)
    puts "\t\tWelcome #{@player2}, In this level, you will have #{@chances}
    chances to guess the word correctly"
    word_genegrator(@min, @max) if @player1.nil?
    challenge_word(@min, @max) if @player1.nil? == false
    trials(@chances)
  end

  def initialize_specs(player, min, max, chances, another_player)
    @player2 = player
    @min = min
    @max = max
    @chances = chances
    @player1 = another_player
  end

  def word_genegrator(min, max)
    words = File.open("./dictionary.txt", "r").readlines.map!(&:chomp)
    level_words = words.select { |i| i.length >= min && i.length <= max }
    random_index = rand(level_words.length)
    @game_word = level_words[random_index]
  end

  def challenge_word(min, max)
    puts "Now, enter your challenge_word #{@player1}, it will be hidden"
    @game_word = STDIN.noecho(&:gets).chomp.downcase.delete(" ")
    until @game_word.length >= min && @game_word.length <= max &&
          number?(@game_word)
      puts "Word length not correct!Make it between #{min} & #{max} characters"
      @game_word = STDIN.noecho(&:gets).chomp.downcase.delete(" ")
    end
    puts "The stage is set #{@player2}"
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

  def compare_guess
    if @game_word.include?(@guess) == false
      wrong_guess
    else
      correct_guess
    end
  end

  def setup
    @word_control = ""
    @game_word.length.times { @word_control << "_" }
    @count = 0
    puts @word_control.gsub("_", "__ ")
  end

  def wrong_guess
    @misses << @guess
    puts "Bad guess, the noose tightens".red
    puts "Try again"
    puts @word_control.gsub("_", " __ ").upcase
  end

  def correct_guess
    @game_word.each_char.with_index do |letter, index|
      right_guess(letter, index)
    end
    @right_guesses << @guess
    puts @word_control.gsub("_", " __ ").upcase
  end

  def right_guess(letter, index)
    if letter == @guess
      if @word_control.include?(@guess) == false
        @count += 1
        puts "Nice one!".green
      end
      @word_control[index] = @guess
    end
  end

  def verify_guess
    puts "Enter a guess"
    @guess = gets.chomp.downcase
    cheat_or_quit_or_history
    until length_one?(@guess) && unique?(@guess) && number?(@guess)
      @guess = gets.chomp.downcase
      puts @game_word if @guess == ":c"
      puts "Your missed guesses: #{@misses.join(', ')}" if @guess == ":h"
    end
  end

  def cheat_or_quit_or_history
    if @guess == ":c"
      puts @game_word
      verify_guess
    elsif @guess == "quit" || @guess == ":q"
      quit_or_save
    elsif @guess == ":h" || @guess == "history"
      history_verify_guess
    end
  end

  def history_verify_guess
    history
    verify_guess
  end

  def quit_or_save
    exit if @player1.nil? == false
    puts "Do you want to save your game? type 'Yes' or 'No'"
    choice = gets.chomp.downcase
    until choice == "yes" || choice == "no"
      puts "Please type a 'Yes' or a 'No'"
      choice = gets.chomp.downcase
    end
    choice == "no" ? exit : save_game
  end

  def save_game
    game_data = GameData.new(@player2, @misses, @right_guesses,
                             @chances - @counter, @word_control,
                             @game_word, @count)
    File.open("games.yml", "a") { |data| YAML.dump(game_data, data) }
    puts "Goodbye, your game has been saved successfully".green
    exit
  end

  def history
    if @misses.empty? && @right_guesses.empty?
      puts "you have not entered any guesses"
    else
      print_history
    end
  end

  def print_history
    if @misses.empty? && @right_guesses.empty? == false
      puts "your right guesses are #{@right_guesses.join(', ')} but no misses"
    elsif @misses.empty? == false && @right_guesses.empty?
      puts "your misses are #{@misses.join(', ')} & you have no right guesses"
    else
      puts "\tyour misses are #{@misses.join(', ')} and your
      right guesses are #{@right_guesses.join(', ')}"
    end
  end

  def win_game(chances, counter)
    if @count == @game_word.chars.uniq.length
      puts "Congratulations #{@player2}! You have won the game".green
      exit
    end
    puts "You have #{chances - 1 - counter} chance(s) left"
  end

  def end_game
    puts "Game over! You are dead, sorry #{@player2}".red
    puts "The word is #{@game_word.upcase}"
    Message.end_games
    choice_integrity
  end
end
end
