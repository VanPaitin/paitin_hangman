require "colorize"
require "io/console"
require "yaml"
require_relative "simple_methods"
require_relative "messages"
require_relative "game_data"
module PaitinHangman
  class Levels
    attr_reader :player2, :min, :max, :chances, :player1, :game_word
    include SimpleMethods
    def initialize(player, min, max, chances, another_player = nil)
      initialize_specs(player, min, max, chances, another_player)
      puts "\t\tWelcome #{@player2}, In this level, you will have #{@chances}
      chances to guess the word correctly"
      word_generator(min, max) if @player1.nil?
      challenge_word(min, max) if @player1
      GameEngine.new.trials(@chances, @game_word, @player2, @player1)
    end

    def initialize_specs(player, min, max, chances, another_player)
      @player2 = player
      @min = min
      @max = max
      @chances = chances
      @player1 = another_player
    end

    def word_generator(min, max, path = "")
      file_name = File.join(File.dirname(File.expand_path(__FILE__)), '../../dictionary.txt')
      words = File.open(file_name, "r").readlines.map!(&:chomp)
      level_words = words.select { |i| i.length >= min && i.length <= max }
      random_index = rand(level_words.length)
      @game_word = level_words[random_index]
    end

    def challenge_word(min, max)
      puts "Now, enter your challenge_word #{@player1}, it will be hidden"
      @game_word = STDIN.noecho(&:gets).chomp.downcase.delete(" ")
      until @game_word.length >= min && @game_word.length <= max &&
            number?(@game_word)
        puts "Word length not correct! Make it between #{min} & #{max} characters"
        @game_word = STDIN.noecho(&:gets).chomp.downcase.delete(" ")
      end
      puts "The stage is set #{@player2}"
    end

  end
end
