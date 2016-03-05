module PaitinHangman
class GameData
  attr_reader :player_name, :misses, :right_guesses, :chances, :word_control, :game_word, :count

  def initialize(player_name, misses, right_guesses, chances, word_control, game_word, count)
    @player_name = player_name
    @misses = misses
    @right_guesses = right_guesses
    @chances = chances
    @word_control = word_control
    @game_word = game_word
    @count = count
  end

  def to_s
    "#{player_name}  ===>>>     #{word_control.upcase.gsub('_', '__ ')}\n"\
		"\t   #{chances} chances left and you have used #{misses.join(', ')}\n"
  end
end
end