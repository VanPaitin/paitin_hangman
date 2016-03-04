require_relative "paitin_hangman/messages"
require_relative "paitin_hangman/saved_games"
require_relative "paitin_hangman/version"
require_relative "paitin_hangman/game_engine"
module PaitinHangman
  class Paitin
    include SimpleMethods
    def game_control
      Message.welcome
      process
    end

    def process
      choice = gets.chomp.downcase
      choice_integrity(choice)
    end

    def choice_integrity(choice)
      case choice
      when "p", "play" then new_game
      when "i", "instruction" then instruction
      when "q", "quit" then exit
      when "l", "load" then GameResumption.new
      else
        try_again
      end
    end

    def try_again
      Message.valid_option
      process
    end

    def instruction
      Message.instruction
      process
    end

    def new_game
      Message.game_intro
      name = verify_name_integrity
      puts "Hi #{name}, Select a mode"
      play(name)
    end
  end
end
