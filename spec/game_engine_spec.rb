require 'spec_helper'
describe PaitinHangman::GameEngine do

  before(:all) do
    
    @game = PaitinHangman::GameEngine.new
    @game.instance_variable_set("@game_word", "liquidize")
    @game.instance_variable_set("@player2", "MAYOWA")
    @game.instance_variable_set("@player1", "SIMON")
  end
  describe '#trials' do
    it 'should run the game successfully' do
      allow(@game).to receive(:setup).and_return(nil)
      allow(@game).to receive(:verify_guess).and_return(nil)
      allow(@game).to receive(:compare_guess).and_return(nil)
      allow(@game).to receive(:win_game).and_return(nil)
      allow(@game).to receive(:end_game).and_return(nil)
      expect(@game.trials(10, @game_word, @player2, @player1)).to eql nil
    end
  end

  describe '#compare_guess' do
    before(:each) do
      allow(@game).to receive(:wrong_guess).and_return("wrong value")
      allow(@game).to receive(:correct_guess).and_return("correct")
      @game.instance_variable_set("@game_word", "liquidize")
    end

    it "checks for a wrong guess" do
      @game.instance_variable_set("@guess", "a")
      expect(@game.compare_guess).to eql "wrong value"
    end

    it "checks for a right_guess" do
      @game.instance_variable_set("@guess", "i")
      expect(@game.compare_guess).to eql "correct"
    end
  end

  describe "#setup" do

    before(:each) do
      @game.instance_variable_set("@word_control", "_")
      @game.instance_variable_set("@count", 34)
    end

    context "it prepares the game and prints the dashes" do
      specify {  expect { @game.setup("liquidize", @player2, @player1) }.to output("__ __ __ __ __ __ __ __ __ \n").to_stdout }
    end
    it "can make count zero" do
      @game.setup("liquidize", @player2, @player1)
      expect(@game.count).to eql(0)
    end

  end

  describe '#wrong_guess' do
    it "should add a wrong guess to the 'misses' array" do
      @game.instance_variable_set("@misses", [])
      @game.instance_variable_set("@guess", "e")
      @game.wrong_guess
      expect(@game.misses.length).to eql 1
    end
  end

  describe '#correct_guess' do

    before(:each) do
      @game.instance_variable_set("@guess", "i")
      @game.instance_variable_set("@word_control", "_________")
      @game.instance_variable_set("@right_guesses", [])
    end

    it 'can substitute the right guess' do
      @game.correct_guess
      expect(@game.right_guesses.length).to eql 1
    end

    context 'it should print the word_control status' do
      specify { expect { @game.correct_guess }.to output("Nice one!".green + "\n __ I __  __ I __ I __  __ \n").to_stdout }
    end
  end

  describe '#verify_guess' do
    it "collects a good guess from the user" do
      @game.instance_variable_set("@guess", 4)
      allow(@game).to receive(:gets).and_return('7')
      allow(@game).to receive(:cheat_or_quit_or_history).and_return('7')
      allow(STDIN).to receive(:gets).and_return('f')
      @game.verify_guess("and_return")
      expect(@game.guess).to eql 'f'
    end
  end

  describe '#cheat_or_quit_or_history' do
    before(:each) do
      @game.instance_variable_set("@guess", ":c")
      allow(@game).to receive(:verify_guess).and_return(nil)
    end
    context "it can reveal the game_word" do
      
      specify { expect {@game.cheat_or_quit_or_history("and_return")}.to output("liquidize\n").to_stdout }
    end

    it 'can quit or save a game' do
      @game.instance_variable_set("@guess", ":q")
      allow(@game).to receive(:quit_or_save).and_return("quit")
      expect(@game.cheat_or_quit_or_history("and_return")).to eql "quit"
    end

    it 'can print the history' do
      @game.instance_variable_set("@guess", ":h")
      allow(@game).to receive(:verify_guess).and_return(nil)
      expect(@game.cheat_or_quit_or_history("and_return")).to eql nil
    end
  end

  describe '#quit_or_save' do

    it "should terminate the game after saving it" do
      allow(STDIN).to receive(:gets).and_return('y', 'yes')
      allow(@game).to receive(:save_game).and_return("Saved successfully")
      expect(@game.quit_or_save("and_return")).to eql "Saved successfully"
    end

    it "should simply end the program" do
      allow(STDIN).to receive(:gets).and_return('n', 'no')
      allow(@game).to receive(:exit).and_return("bye")
      expect(@game.quit_or_save("and_return")).to eql "bye"
    end
  end

  describe '#save_game' do

    before(:each) do
      allow(@game).to receive(:exit).and_return(nil)
    end
    specify { expect { @game.save_game(0)}.to output("Goodbye, your game has been saved successfully".green + "\n").to_stdout}
    it "can exit the game" do
      
      expect(@game.save_game(0)).to eql nil
    end
  end

  describe "#history" do
    before(:each) do
      @game.instance_variable_set("@misses",[])
      @game.instance_variable_set("@right_guesses",[])
    end
    context "can tell the user he has no guesses" do

      specify { expect { @game.history }.to output("you have not entered any guesses\n").to_stdout }
    end
  end

  describe "#print_history" do

    context "should print the right message(:context)" do
      before do
        @game.instance_variable_set("@misses",[])
        @game.instance_variable_set("@right_guesses",["a", "b"])
      end
      specify { expect { @game.print_history}.to output("your right guesses are a, b but no misses\n").to_stdout }
    end

    context "should print another right message(:example)" do
      before do
        @game.instance_variable_set("@misses",["c", "d"])
        @game.instance_variable_set("@right_guesses",[])
      end
      specify { expect { @game.print_history}.to output("your misses are c, d & you have no right_guesses\n").to_stdout }
    end

  end
  
  describe '#win_game' do
    before(:each) do
      allow(@game).to receive(:exit).and_return("exit")
      @game.instance_variable_set("@count", 7)
    end
    context 'congratulates the player and end the game successfully' do
      
      specify { expect { @game.win_game(8, 6, @game.player2) }.to output("Congratulations #{@game.player2}! You have won the game".green + 
        "\nYou have 1 chance(s) left\n").to_stdout }
    end
  end

  describe '#end_game' do
    it 'can end the game successfully' do 
      allow(@game).to receive(:choice_integrity).and_return('q')
      expect(@game.end_game).to eql 'q'
    end
  end
end