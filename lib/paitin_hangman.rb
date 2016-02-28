require_relative "paitin_hangman/messages"
require_relative "paitin_hangman/game_play"
require_relative "paitin_hangman/saved_games"
module PaitinHangman
  class Paitin
    def game_control
      Message.welcome
      process
    end

    def process
      choice = STDIN.gets.chomp.downcase
      choice_integrity(choice)
    end

    def choice_integrity(choice)
      case choice
      when "p", "play" then Game.new
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
  end
end
PaitinHangman::Paitin.new.game_control
