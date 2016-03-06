require_relative "messages"

module PaitinHangman
  module SimpleMethods
    # => This method verifies the integrity of names
    def verify_name_integrity
      name = gets.chomp.upcase.strip
      while name.scan(/[^A-Z\s-]/).empty? == false || name.empty? # => It scans for anything other than a letter, a space or a dash
        Message.verify_name
        name = STDIN.gets.chomp.upcase.strip
      end
      name
    end

    # => The method makes sure a valid option is picked

    def option_integrity
      @option = gets.chomp
      until @option == "1" || @option == "2"
        puts "Enter either a '1' or a '2'"
        @option = STDIN.gets.chomp
      end
      @option
    end

    def length_one?(parameter)
      if parameter.length == 1
        return true
      else
        puts "Enter just one letter or an hyphen or an apostrophe"
        return false
      end
    end

    def unique?(parameter)
      if @misses.include?(parameter) || @right_guesses.include?(parameter)
        puts "You have used #{parameter} already, try again"
        return false
      else
        return true
      end
    end

    def number?(parameter)
      if parameter.scan(/\d/).empty?
        return true
      else
        puts "You cannot enter a number! Try again"
        return false
      end
    end
    
    def choice_integrity
      choice = gets.chomp.downcase
      until choice == "r" || choice == "q" || choice == "quit"
        puts "You must enter either a 'r' or 'q' or type 'quit'"
        choice = STDIN.gets.chomp.downcase
      end
      decide(choice)
    end

    def decide(choice)
      if choice == "r"
        @player1 ? Paitin.new.play(@player1) : Paitin.new.play(@player2)
      else
        exit
      end
    end
  end
end
