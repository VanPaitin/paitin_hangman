require 'spec_helper'

describe PaitinHangman::Levels do 
  before(:all) do
    class Dummy < PaitinHangman::Levels
      attr_reader :count, :misses, :word_control, :right_guesses, :guess
      def challenge_word(min, max, use_super = false)
        return nil unless use_super
        super(min, max)
      end
      def trials(item, use_super = false)
        return nil unless use_super
        super(item)
      end
    end
    @level = Dummy.new("MAYOWA", 4, 8, 10, "SIMON")
    @level.instance_variable_set("@game_word", "liquidize")

  end

  describe '#initialize_specs' do

    it "can set the instance variable of the level class" do
      expect(@level.player2).to eql "MAYOWA"
      expect(@level.min).to eql 4
      expect(@level.max).to eql 8
      expect(@level.chances).to eql 10
      expect(@level.player1).to eql "SIMON"
    end
  end

  describe '#word_generator' do
    it 'generates just the right word' do
      expect(@level.word_generator(@level.min, @level.max, "").length).to be >= 4
      expect(@level.word_generator(@level.min, @level.max, "").length).to be <= 8
    end
  end

  describe '#challenge_word' do

    before(:each) do
      allow(STDIN).to receive(:noecho).and_return("Kol", "Kolapo")
    end

    context "can generate the game_word based on user input" do
      specify{ expect{ @level.challenge_word(@level.min, @level.max, true) }.to output("Now, enter your challenge_word SIMON, it will be hidden\n"+
        "Word length not correct!Make it between 4 & 8 characters\n"+
        "The stage is set MAYOWA\n").to_stdout }
    end
  end

  describe '#trials' do
    it 'should run the game successfully' do
      allow(@level).to receive(:setup).and_return(nil)
      allow(@level).to receive(:verify_guess).and_return(nil)
      allow(@level).to receive(:compare_guess).and_return(nil)
      allow(@level).to receive(:win_game).and_return(nil)
      allow(@level).to receive(:end_game).and_return(nil)
      expect(@level.trials(10, true)).to eql nil
    end
  end

  describe '#compare_guess' do
    before(:each) do
      allow(@level).to receive(:wrong_guess).and_return("wrong value")
      allow(@level).to receive(:correct_guess).and_return("correct")
      @level.instance_variable_set("@game_word", "liquidize")
    end

    it "checks for a wrong guess" do
      @level.instance_variable_set("@guess", "a")
      expect(@level.compare_guess).to eql "wrong value"
    end

    it "checks for a right_guess" do
      @level.instance_variable_set("@guess", "i")
      expect(@level.compare_guess).to eql "correct"
    end
  end

  describe "#setup" do

    before(:each) do
      @level.instance_variable_set("@word_control", "_")
      @level.instance_variable_set("@count", 34)
    end

    context "it prepares the game and prints the dashes" do
      specify {  expect { @level.setup }.to output("__ __ __ __ __ __ __ __ __ \n").to_stdout }
    end
    it "can make count zero" do
      @level.setup
      expect(@level.count).to eql(0)
    end

  end

  describe '#wrong_guess' do
    it "should add a wrong guess to the 'misses' array" do
      @level.instance_variable_set("@misses", [])
      @level.instance_variable_set("@guess", "e")
      @level.wrong_guess
      expect(@level.misses.length).to eql 1
    end
  end

  describe '#correct_guess' do

    before(:each) do
      @level.instance_variable_set("@guess", "i")
      @level.instance_variable_set("@word_control", "_________")
      @level.instance_variable_set("@right_guesses", [])
    end

    it 'can substitute the right guess' do
      @level.correct_guess
      expect(@level.right_guesses.length).to eql 1
    end

    context 'it should print the word_control status' do
      specify { expect { @level.correct_guess }.to output("Nice one!".green + "\n __ I __  __ I __ I __  __ \n").to_stdout }
    end
  end

  describe '#verify_guess' do
    it "collects a good guess from the user" do
      @level.instance_variable_set("@guess", 4)
      allow(@level).to receive(:gets).and_return('7')
      allow(@level).to receive(:cheat_or_quit_or_history).and_return('7')
      allow(STDIN).to receive(:gets).and_return('f')
      @level.verify_guess
      expect(@level.guess).to eql 'f'
    end
  end

  describe '#cheat_or_quit_or_history' do
    before(:each) do
      @level.instance_variable_set("@guess", ":c")
      allow(@level).to receive(:verify_guess).and_return(nil)
    end
    context "it can reveal the game_word" do
      
      specify { expect {@level.cheat_or_quit_or_history}.to output("liquidize\n").to_stdout }
    end

    it 'can quit or save a game' do
      @level.instance_variable_set("@guess", ":q")
      allow(@level).to receive(:quit_or_save).and_return("quit")
      expect(@level.cheat_or_quit_or_history).to eql "quit"
    end

    it 'can print the history' do
      @level.instance_variable_set("@guess", ":h")
      allow(@level).to receive(:verify_guess).and_return(nil)
      expect(@level.cheat_or_quit_or_history).to eql nil
    end
  end

  describe '#quit_or_save'

  describe '#win_game' do
    before(:each) do
      allow(@level).to receive(:exit).and_return("exit")
      @level.instance_variable_set("@count", 7)
    end
    context 'congratulates the player and end the game successfully' do
      
      specify { expect { @level.win_game(8, 6, @level.player2) }.to output("Congratulations #{@level.player2}! You have won the game".green + 
        "\nYou have 1 chance(s) left\n").to_stdout }
    end
  end

  describe '#end_game' do
    it 'can end the game successfully' do 
      allow(@level).to receive(:choice_integrity).and_return('q')
      expect(@level.end_game).to eql 'q'
    end
  end

end 