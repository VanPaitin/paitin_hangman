require 'spec_helper'

describe "PaitinHangman::GameResumption" do
  
end

describe PaitinHangman::Saved do
  before :each do
    @instance = PaitinHangman::Saved.new("player_name", ['m', 'i', 's', 's', 'e', 's'], %w{r i g h t g u e s s e s},
                                             "chances", "word_control", "gameword", "count")
  end

  describe '#new' do
    it 'returns a new game object' do
      expect(@instance).to be_a PaitinHangman::Saved
    end

    it 'throws an error when instantiated with less than seven parameters' do
      expect{PaitinHangman::Saved.new "lala", "in the mighty"}.to raise_error ArgumentError
    end
  end

  # describe '#trials' do
  #   it 'can run a resmed game successfully' do
  #     allow(@level).to receive(:setup).and_return(nil)
  #     allow(@level).to receive(:verify_guess).and_return(nil)
  #     allow(@level).to receive(:compare_guess).and_return(nil)
  #     allow(@level).to receive(:win_game).and_return(nil)
  #     allow(@level).to receive(:end_game).and_return(nil)
  #     expect(@level.trials(10, true)).to eql nil
  #   end
  # end
end