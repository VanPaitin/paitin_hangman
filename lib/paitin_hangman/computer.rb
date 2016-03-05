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
end