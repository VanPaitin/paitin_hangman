require 'spec_helper'
  
describe PaitinHangman::GameResumption do
  class Dummys < PaitinHangman::GameResumption
    def initialize(test = false)
      super() unless test
    end
    def initialize_cont(name, test = false)
      super(name) if test
    end
  end
  before :each do
    @instance = Dummys.new(true)
  end

  describe '#new' do
    it 'returns a new game object' do
      allow(STDIN).to receive(:gets).and_return("Simon")
      expect(Dummys.new).to be_a Dummys
    end

    it 'throws an error when instantiated with less than seven parameters' do
      expect{PaitinHangman::GameResumption.new "lala", "in the mighty"}.to raise_error ArgumentError
    end
  end

  describe "#initialize_cont" do
    context "checkes whether a name given has a saved game" do
      before do
        @instance.instance_variable_set("@saved_game", [])
        allow(@instance).to receive(:exit).and_return(nil)
      allow(@instance).to receive(:print_history).and_return(nil)
      allow(@instance).to receive(:choice_integrity).and_return(nil)
      end
      
      specify { expect { @instance.initialize_cont("Mayowa", true) }.to output("You have no saved game with that name".red + "\n" + "START A NEW GAME INSTEAD".yellow + "\n" + "Here are the saved games found for Mayowa\n\n").to_stdout }
    end
  end

  describe "#choice_integrity" do
    it "ensures the user types the game that he wants" do
      allow(STDIN).to receive(:gets).and_return("5", "2")
      @instance.instance_variable_set("@saved_game", ["a", "b", "c", "d"])
      allow(@instance).to receive(:load_properties).and_return("properties")
      expect(@instance.choice_integrity).to eql "properties"
    end
  end
  describe '#trials' do
    it 'can run a resmed game successfully' do
      allow(@instance).to receive(:verify_guess).and_return(nil)
      allow(@instance).to receive(:compare_guess).and_return(nil)
      allow(@instance).to receive(:win_game).and_return(nil)
      allow(@instance).to receive(:end_game).and_return(nil)
      expect(@instance.trials(10)).to eql nil
    end
  end
end