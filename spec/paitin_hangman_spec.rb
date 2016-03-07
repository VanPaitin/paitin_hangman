require 'spec_helper'

describe PaitinHangman do
  it 'has a version number' do
    expect(PaitinHangman::VERSION).not_to be nil
  end

end

describe 'Paitin' do

  before :each do
    @instance = PaitinHangman::Paitin.new
  end

  describe '#new' do
    it 'returns a new game object' do
      expect(@instance).to be_a PaitinHangman::Paitin
    end

    it 'throws an error when instantiated with one or more parameters' do
      expect{PaitinHangman::Paitin.new "lala"}.to raise_error ArgumentError
    end
  end

  describe '#choice_integrity' do

    it 'returns an instance of Game' do
      allow(@instance).to receive(:new_game).and_return(nil)
      expect(@instance.choice_integrity('p')).to eql nil
    end

    it 'gives an intruction and then calls the #process method' do
      allow(@instance).to receive(:process).and_return(nil)
      expect(@instance.choice_integrity('i')).to eql (nil)
    end

    it 'can quit the program' do
      allow(@instance).to receive(:exit).and_return(nil)
      expect(@instance.choice_integrity('q')).to eql nil
    end

    it 'can load a saved game' do
      allow(PaitinHangman::GameResumption).to receive(:new).and_return(nil)
      expect(@instance.choice_integrity('l')).to eql nil
    end

    it 'can repeat the process' do
      allow(@instance).to receive(:process).and_return(nil)
      expect(@instance.choice_integrity(2)).to eql nil
    end
  end

  describe '#instruction' do

    it 'returns the process method' do
      allow(@instance).to receive(:process).and_return(nil)
      expect(@instance.instruction).to eql nil
    end

  end

  describe '#game_control' do
    it 'can print a message to the screen' do
      allow(@instance).to receive(:process).and_return(nil)
      expect(@instance.game_control).to eql nil
    end
  end

  describe '#process' do
    it "can receive an input from the user" do
      allow(@instance).to receive(:gets).and_return("p")
      allow(@instance).to receive(:choice_integrity).and_return(nil)
      expect(@instance.process).to eql nil
    end
  end

  describe '#new_game' do
    context 'it can print a message to the console' do
      specify {expect{PaitinHangman::Message.game_intro}.to output("Now that you have chosen to play".green + "\n" + "What is your name: ".green).to_stdout}
    end

    it 'should begin a new game' do
      allow(@instance).to receive(:verify_name_integrity).and_return('Mayowa')
      allow(@instance).to receive(:play).and_return(nil)
      expect(@instance.new_game).to eql nil
    end
  end

  describe '#play' do
    before(:each) do
      @computer = PaitinHangman::Computer.new
      @player = PaitinHangman::Player.new
      allow(@instance).to receive(:option_integrity).and_return(nil)
      allow(PaitinHangman::Computer).to receive(:new).and_return(@computer)
      allow(PaitinHangman::Player).to receive(:new).and_return(@player)
    end

    context "if it is '2'" do

      it "should begin a computer game" do
        allow(@computer).to receive(:level_integrity).and_return("computer game")
        @instance.instance_variable_set("@option", '2')
        expect(@instance.play("Simon")).to eql "computer game"
      end
    end

    context "if it is '1'" do

      it "should begin a player game" do
        allow(@player).to receive(:first_player_name).and_return("player game")
       
        expect(@instance.play("Simon")).to eql "player game"
      end
    end
  
  end

end
