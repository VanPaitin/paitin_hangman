
# This Message class basically supplies the game with
# messages to guide the user

require "colorize"
module PaitinHangman
  class Message
    # => The welcome message introduces the game to the player
    def self.welcome
      puts "\tWelcome to Hangman, the no-nonsense game
      Be smart, then you live. if not, you'll have to die by Hanging.
      You have a couple of options to pick from.....
      Press 'P' or 'play' if you think you are ready for the challenge,
      You may press 'I' or 'instructions' for a short explanation of how to play
      You may continue a previously saved game by pressing 'L' or 'load'
      Or you could just quit by pressing a 'Q' or typing 'quit'".green
    end
    # => The instruction tells the user what the game is about

    def self.instruction
      puts "\tThe word to guess is represented by a row of dashes
      These dashes represent each letter of the word.
      Words you cannot use include proper nouns such as names, places, and brands.
      If the guessing player suggests a letter which occurs in the word,
      the other player writes it in all its correct positions.".yellow
      Message.instruction_continue
    end

    def self.instruction_continue
      puts "\tThe guessing player wins the game if he gets all letters correctly
      within number of chances afforded. He loses if he exhausts all his chances
      without getting all the letters of the word completely".yellow
      puts "\tNow decide whether you want to 'p'lay or 'q'uit.
      Please do keep in mind that you can press ':h' or 'history' at any time
      during the game to show your guess history or ':q'/'quit' to exit the game
      While quitting the game, you may quit directly or decide to save your
      session to resume at a later time at which point you must press 's'".yellow
    end
    # => This method basically instructs the player to pick a valid option

    def self.valid_option
      puts "Try and enter a valid option: 'p', 'i', 'l' or 'q'".yellow
    end
    # => game logic

    def self.game_intro
      puts "Now that you have chosen to play".green
      print "What is your name: ".green
    end
    # => Instructs the user to enter a valid name

    def self.verify_name
      puts "Please enter your real name, I don't think it is just a".red
      puts "space or it contains numbers.".red
    end
    # => game logic

    def self.game_type
      puts "1)\tPlay against a Human Player, press 1\n"\
      "2)\tPlay against Computer, press 2"
    end
    # informs the player of the levels available & their respective difficulties

    def self.level_choice
      puts "    Enter the Level you would like to play. You may press...
      1 for Beginner (4 - 8 character word)
      2 for Intermediate (9 - 12 character word)
      3 for Advanced (word has above 12 characters)".yellow
    end

    def self.end_games
      puts "Press 'r' to restart the game or 'q' to quit."
    end
  end
end