require 'spec_helper'

describe "PaitinHangman::GameData" do 

  before :each do
    @instance = PaitinHangman::GameData.new("player_name", ['m', 'i', 's', 's', 'e', 's'], %w{r i g h t g u e s s e s},
                                             "chances", "word_control", "gameword", "count")
  end

  describe '#new' do
    it 'returns a new game object' do
      expect(@instance).to be_a PaitinHangman::GameData
    end

    it 'throws an error when instantiated with less than seven parameters' do
      expect{PaitinHangman::GameData.new "lala", "in the mighty"}.to raise_error ArgumentError
    end
  end

  describe '#to_s' do
    it 'can return a readable representation of a game object' do

      expect(@instance.to_s).to eql "player_name  ===>>>     WORD__ CONTROL\n"\
                                    "\t   chances chances left and you have used m, i, s, s, e, s\n"
    end
  end
  
end