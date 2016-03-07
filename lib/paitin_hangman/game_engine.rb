require_relative "messages"
require_relative "levels"

module PaitinHangman
  class GameEngine
    include SimpleMethods
    def initialize
      @misses = []
      @right_guesses = []
    end

    def trials(chances, game_word, player2, player1)
      setup(game_word, player2, player1)
      chances.times do |counter|
        @counter = counter
        verify_guess(chances)
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

    def setup(game_word, player2, player1)
      @player2 = player2
      @player1 = player1
      @game_word = game_word
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

    def verify_guess(chances)
      puts "Enter a guess"
      @guess = gets.chomp.downcase
      cheat_or_quit_or_history(chances)
      until length_one?(@guess) && unique?(@guess) && number?(@guess)
        @guess = STDIN.gets.chomp.downcase
        puts @game_word if @guess == ":c"
        puts "Your missed guesses: #{@misses.join(', ')}" if @guess == ":h"
      end
    end

    def cheat_or_quit_or_history(chances)
      if @guess == ":c"
        puts @game_word
        verify_guess(chances)
      elsif @guess == "quit" || @guess == ":q"
        quit_or_save(chances)
      elsif @guess == ":h" || @guess == "history"
        history_verify_guess(chances)
      end
    end

    def history_verify_guess(chances)
      history
      verify_guess(chances)
    end

    def quit_or_save(chances)
      exit if @player1.nil? == false
      puts "Do you want to save your game? type 'Yes' or 'No'"
      choice = STDIN.gets.chomp.downcase
      until choice == "yes" || choice == "no"
        puts "Please type a 'Yes' or a 'No'"
        choice = STDIN.gets.chomp.downcase
      end
      choice == "no" ? exit : save_game(chances)
    end

    def save_game(chances)
      game_data = GameData.new(@player2, @misses, @right_guesses,
                               (chances - @counter), @word_control,
                               @game_word, @count)
      file_name = File.join(File.dirname(File.expand_path(__FILE__)), '../../games.yml')
      File.open(file_name, "a") { |data| YAML.dump(game_data, data) }
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

    def win_game(chances, counter, player = @player2)
      if @count == @game_word.chars.uniq.length
        puts "Congratulations #{player}! You have won the game".green
        exit
      end
      puts "You have #{chances - 1 - counter} chance(s) left"
    end

    def end_game(player = @player2)
      puts "Game over! You have been HANGED! Sorry #{player}".red
      puts "The word is #{@game_word.upcase}"
      Message.end_games
      choice_integrity
    end
  end
end
