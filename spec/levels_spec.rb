require 'spec_helper'

describe PaitinHangman::Levels do 
  before(:all) do
    class Dummy < PaitinHangman::Levels
      attr_reader :count, :word_control, :guess
      def challenge_word(min, max, use_super = false)
        return nil unless use_super
        super(min, max)
      end

    end
    @level = Dummy.new("MAYOWA", 4, 8, 10, "SIMON")
    @level.instance_variable_set("@game_word", "liquidize")

  end

  describe '#initialize_specs' do

    context "can set the instance variable of the level class" do
      it { expect(@level.player2).to eql "MAYOWA" }
      it { expect(@level.min).to eql 4 }
      it { expect(@level.max).to eql 8 }
      it { expect(@level.chances).to eql 10 }
      it { expect(@level.player1).to eql "SIMON" }
    end
  end

  describe '#word_generator' do
    before(:each) do
      p = PaitinHangman::GameEngine.new
      allow(p).to receive(:trials).and_return nil
      allow(PaitinHangman::GameEngine).to receive(:new).and_return p
    end

    it 'generates just the right word' do
      @level.word_generator(4, 8)
      expect(@level.game_word.length).to be >= 4
    end

    it "generates just the right word" do
      @level.word_generator(4, 8)
      expect(@level.game_word.length).to be <= 8
    end
    
  end

  describe '#challenge_word' do

    before(:each) do
      allow(STDIN).to receive(:noecho).and_return("Kol", "Kolapo")
      p = PaitinHangman::GameEngine.new
      allow(p).to receive(:trials).and_return nil
      allow(PaitinHangman::GameEngine).to receive(:new).and_return p
    end

    context "can generate the game_word based on user input" do
      specify{ expect{ @level.challenge_word(@level.min, @level.max, true) }.to output("Now, enter your challenge_word SIMON, it will be hidden\n"+
        "Word length not correct! Make it between 4 & 8 characters\n"+
        "The stage is set MAYOWA\n").to_stdout }
    end
  end

end 