require_relative "game_engine"
module PaitinHangman
  class GameResumption < GameEngine
    attr_reader :all_games
    def initialize
      file_name = File.join(File.dirname(File.expand_path(__FILE__)), '../../games.yml')
      @all_games = YAML.load_stream(File.open(file_name, "a+"))
      puts "Enter the name you used to store the game"
      name = STDIN.gets.chomp.upcase
      @saved_game = all_games.select do |game|
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
      choice_integrities
    end

    def choice_integrities
      puts "Now enter the number for the game you want to play".blue
      @choice = STDIN.gets.chomp.to_i
      until @choice > 0 && @choice <= @saved_game.length
        puts "Enter a number that has a game please"
        @choice = STDIN.gets.chomp.to_i
      end
      @choice -= 1
      load_properties
    end

    def load_properties
      @game_object = @saved_game[@choice]
      @name = @game_object.player_name
      @misses = @game_object.misses
      @right_guesses = @game_object.right_guesses
      @chances = @game_object.chances
      @word_control = @game_object.word_control
      @game_word = @game_object.game_word
      load_properties_cont
    end

    def load_properties_cont
      @count = @game_object.count
      trials(@chances)
    end

    def print_function
      @saved_game.length.times do |index|
        print "#{index + 1}.\t"
        puts @saved_game[index], "\n"
      end
    end
    

    def trials(chances)
      setup
      chances.times do |counter|
        @counter = counter
        verify_guess(chances)
        compare_guess
        win_game(chances, counter, @name)
      end
      end_game(@name)
    end

    def setup
      puts "Now, continue playing..."
      puts @word_control.gsub("_", "__ ").upcase
    end
  end
end